from pathlib import Path
import io, math, zipfile, json
import xml.etree.ElementTree as E
from xml.sax.saxutils import escape
import numpy as np, cv2, trimesh as tm, resvg_py
from PIL import Image,ImageDraw,ImageFont
from shapely import affinity, union_all
from shapely.geometry import Polygon, MultiPolygon, LineString, box, Point
out=Path('../../outputs/INDX_covers')
source=Path('../../outputs/threaded_insert/cover_plate.stl')
profile=Path('package/profile.json').read_text()
def contours(mask):
    cs,h=cv2.findContours(np.uint8(mask),cv2.RETR_CCOMP,cv2.CHAIN_APPROX_SIMPLE)
    paths=[cv2.approxPolyDP(c,.9,True)[:,0,:] for c in cs]
    polys=[]
    for i,pts in enumerate(paths):
        if len(pts)<3 or h[0,i,3]>=0:continue
        holes=[paths[j] for j in range(len(cs)) if h[0,j,3]==i and len(paths[j])>=3]
        polys.append(Polygon(pts,holes).buffer(0))
    return union_all(polys)
def place(p,width,x=0,y=0):
    l,b,r,t=p.bounds
    p=affinity.translate(p,-(r+l)/2,-(t+b)/2)
    return affinity.translate(affinity.scale(p,width/(r-l),-width/(r-l),origin=(0,0)),x,y)
def inscription():
    path=Path.home()/'Library/Fonts/Goudy Mediaeval DemiBold.ttf'
    font=ImageFont.truetype(str(path),420)
    image=Image.new('L',(2000,1450))
    draw=ImageDraw.Draw(image)
    for i,word in enumerate(('nečum','a','ser')):
        # The installed font has no ccaron glyph. Keep its c and draw the accent.
        word=word.replace('č','c')
        left,_,right,_=draw.textbbox((0,0),word,font=font,anchor='ls')
        draw.text((1000-(left+right)/2,350+330*i),word,font=font,anchor='ls',fill=255)
        if i==0:
            cx=1000-(left+right)/2+font.getlength('ne')+74
            draw.polygon([(cx+x,350+y) for x,y in
                          [(-51,-249),(-38,-256),(0,-232),(40,-257),(51,-249),(2,-202),(-5,-202)]],fill=255)
    return place(contours(np.array(image)>127),139)
unicorn=place(contours(np.array(Image.open(io.BytesIO(resvg_py.svg_to_bytes(svg_path='unicorn.svg',width=1800,height=1800))))[:,:,3]>127),148)
def hypnosis_spiral():
    # Opposite boundaries leave equal dark and light angles at every radius.
    turns=np.linspace(0,8,8*240+1)
    radii=1.25+2*turns+.55*turns**2+.085*turns**3
    angle=2*np.pi*turns+.65
    edge=np.column_stack((radii*np.cos(angle),radii*np.sin(angle)))
    outer_angle=np.linspace(angle[-1],angle[-1]+np.pi,121)[1:-1]
    rim=radii[-1]*np.column_stack((np.cos(outer_angle),np.sin(outer_angle)))
    return Polygon(np.vstack((edge,rim,-edge[::-1])))
spiral=hypnosis_spiral()
words=inscription()
face=['........','........','.XX..XX.','.XX..XX.','...XX...','..XXXX..','..XXXX..','..X..X..']
pattern=['g.t.d.g.','..gd..t.','.d...g..','t...t..d','..g..d..','d....g..','.t....d.','g..d...t']
def cells(ch):
    # Individual accent tiles have small green seams to avoid non-manifold corner contacts.
    rects=[]
    for j,row in enumerate(face):
        for i,c in enumerate(row):
            if (c=='X' and ch=='X') or (c!='X' and pattern[j][i]==ch):
                x,y=(i-4)*23,(3-j)*23
                inset=0 if ch=='X' else .55
                rects.append(box(x+inset,y+inset,x+23-inset,y+23-inset))
    return union_all(rects)
def extrude(p,z,h):
    p=affinity.scale(p,-1,1,origin=(0,0))
    pp=list(p.geoms) if isinstance(p,MultiPolygon) else [p]
    mesh=tm.util.concatenate([tm.creation.extrude_polygon(q,h,engine='earcut') for q in pp])
    mesh.apply_translation((0,0,z));return mesh
projects=[
 ('01_Unicorn',[(unicorn,2,'Unicorn outline',0,.6)],['#EFEAE3','#854481']),
 ('02_Hypnotic_Spiral',[(spiral,2,'Hypnotic spiral',0,.6)],['#F5F2E8','#20242B']),
 ('03_Creeper',[(cells('X'),2,'Eyes and mouth',0,.6),(cells('d'),2,'Black backing beneath one green layer',.2,.4),(cells('g'),3,'Gray pixels',0,.6),(cells('t'),4,'Light teal pixels',0,.6)],['#59A642','#1D2020','#79847E','#93CFC3']),
 ('04_Toilet_Sign',[(words,2,'Lettering',0,.6)],['#F5F2E8','#20242B'])]
def preview(title,layers,palette,square):
    S=650; image=Image.new('RGB',(S,S),'#E1DDD5'); draw=ImageDraw.Draw(image)
    bd=(19,19,S-19,S-19)
    if square:draw.rounded_rectangle(bd,6,fill=palette[0])
    else:draw.ellipse(bd,fill=palette[0])
    def coords(points):return [(S/2+x*3,S/2-y*3) for x,y in points]
    for p,t,name,z,_ in layers:
        color=palette[t-1] if z==0 else '#468037'
        for q in getattr(p,'geoms',[p]):
            draw.polygon(coords(q.exterior.coords),fill=color)
            for h in q.interiors:draw.polygon(coords(h.coords),fill=palette[0])
    image.save(title+'.png')
    return image
def project(title,layers,colors):
    sq='Creeper' in title
    original=tm.load_mesh('square.stl' if sq else source)
    inserts=[extrude(p,z,h) for p,t,n,z,h in layers]
    body=tm.boolean.difference([original,*inserts],engine='manifold')
    assert abs(original.volume-body.volume-sum(m.volume for m in inserts))<.1
    vols=[(body,1,'Cover and magnet pockets')]+[(m,t,n) for m,(_,t,n,_,_) in zip(inserts,layers)]
    assert all(m.is_volume for m,_,_ in vols)
    model=E.Element('model', {'unit':'millimeter','xml:lang':'en-US','xmlns':'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'})
    for key,value in [('Application','PrusaSlicer-3.0.0-alpha14'),('Title',title)]:
        E.SubElement(model,'metadata',name=key).text=value
    if 'Unicorn' in title:
        E.SubElement(model,'metadata',name='LicenseTerms').text='Unicorn adapted from Sofie Ascherl / OpenMoji, https://openmoji.org/library/emoji-1F984/ . CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/ . Two-tone face inlay.'
    resources=E.SubElement(model,'resources')
    object_id=2*len(vols)+1
    objects=[{'id':object_id,'volumes':[],'object_settings':{'extruder':0}}]
    volume_ids=[]
    for i,(mesh,tool,name) in enumerate(vols,1):
        geom=E.SubElement(E.SubElement(resources,'object',id=str(i)),'mesh')
        vertices=E.SubElement(geom,'vertices')
        for x,y,z in mesh.vertices:
            E.SubElement(vertices,'vertex',x=f'{x:.7f}',y=f'{y:.7f}',z=f'{z:.7f}')
        triangles=E.SubElement(geom,'triangles')
        for a,b,c in mesh.faces:
            E.SubElement(triangles,'triangle',v1=str(a),v2=str(b),v3=str(c))
        volume_id=i+len(vols)
        volume_ids.append(volume_id)
        part=E.SubElement(resources,'object',id=str(volume_id),name=name)
        E.SubElement(E.SubElement(part,'components'),'component',objectid=str(i))
        objects[0]['volumes'].append({'id':volume_id,'type':'ModelPart','source':{'objectIdx':-1,'volumeIdx':-1},'volume_settings':{'extruder':tool}})
    parts=E.SubElement(E.SubElement(resources,'object',id=str(object_id),name=title),'components')
    for volume_id in volume_ids:
        E.SubElement(parts,'component',objectid=str(volume_id))
    E.SubElement(E.SubElement(model,'build'),'item',objectid=str(object_id),transform='1 0 0 0 1 0 0 0 1 124 102.5 0')
    container=json.loads(profile)
    palette=(colors+['#888888']*8)[:8]
    container['configuration']['filament_settings']['filament_colour']=palette
    container['configuration']['project_settings']['extruder_colour']=palette
    project_data={'objects':objects,'project':{'id':'','version':1},'config_containers':[container]}
    img=preview(title,layers,colors,sq)
    stream=io.BytesIO();img.resize((256,256)).save(stream,format='PNG')
    with zipfile.ZipFile(out/(title+'.3mf'),'w',zipfile.ZIP_DEFLATED) as dst:
        for f in ['_rels/.rels','[Content_Types].xml']:dst.writestr(f,(Path("package")/f).read_bytes())
        dst.writestr('Metadata/thumbnail.png',stream.getvalue())
        dst.writestr('Metadata/PrusaSlicer3_project.json',json.dumps(project_data))
        dst.writestr('3D/3dmodel.model',E.tostring(model,encoding='utf-8',xml_declaration=True))
import sys
for p in projects:
    if len(sys.argv)==1 or p[0]==sys.argv[1]: project(*p)
