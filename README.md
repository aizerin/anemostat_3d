# Printable DN 125 air valve

A ventilation valve with a threaded airflow adjustment insert and a removable magnetic cover. The neck has a 115 mm outer diameter and extends 35 mm into the duct from the back of the flange. The cover and holders take 6 × 3 mm disc magnets.

## Print and assemble

1. Print the [body](outputs/threaded_insert/body.stl), four [magnet holders](outputs/threaded_insert/magnet_holder.stl) and eight [glue-in pins](outputs/threaded_insert/holder_pin.stl). Each holder uses two pins.
2. Check the thread fit with the [short samples](outputs/threaded_insert/thread_samples.stl). The [0.15 mm insert](outputs/threaded_insert/insert_015.stl) and the [tighter 0.10 mm insert](outputs/threaded_insert/insert_010.stl) both fit the same body. The number is the nominal clearance per side.
3. Fit the insert from the room side. Remove the cover and turn the insert with the [adjustment key](outputs/threaded_insert/insert_key.stl) to change the outlet gap.
4. Choose the [plain 203 mm cover](outputs/threaded_insert/cover_plate.stl) or one of the two- or four-color print projects below. The magnet pockets are 3.4 mm deep. Orient each pair of magnets so that the cover is attracted to the holder.

The [OpenSCAD model](outputs/threaded_insert/valve.scad) includes the duct, seal, flange, magnet pocket and thread parameters. Use the part selector to view the assembly or export individual parts.

## PrusaSlicer cover projects

Open the 3MF as a project. Each cover prints face down, with the magnet pockets facing up. The included profile uses a Prusa CORE One INDX 8T, 0.4 mm nozzles, the default Prusament PLA preset for PrusaSlicer 3.0.0-alpha14 and a 0.20 mm layer height.

| Project | Size | Tool assignments |
| --- | --- | --- |
| [Unicorn](outputs/INDX_covers/01_Unicorn.3mf) | Ø 203 mm | T1 background, T2 outline |
| [Hypnotic spiral](outputs/INDX_covers/02_Hypnotic_Spiral.3mf) | Ø 203 mm | T1 background, T2 spiral |
| [Creeper](outputs/INDX_covers/03_Creeper.3mf) | 203 × 203 mm | T1 green, T2 black, T3 gray, T4 light teal |
| [Toilet sign](outputs/INDX_covers/04_Toilet_Sign.3mf) | Ø 203 mm | T1 background, T2 lettering |

The toilet sign carries the original Czech inscription “nečum a ser” (“don't stare, just shit”). Darker pixels on the Creeper cover use one green face layer backed by black. The resulting shade depends on filament opacity.

![Front view of the four magnetic covers](outputs/INDX_covers/preview.png)

## Artwork sources

The [artwork directory](work/artwork) contains the generator and its inputs. To regenerate the projects, run `python build.py` from that directory with Pillow, NumPy, opencv-python-headless, trimesh, manifold3d, mapbox-earcut, Shapely, SciPy and resvg-py installed. The generator reads Goudy Mediaeval DemiBold from the user's macOS Fonts directory. The ready-to-print projects include the letter outlines.

## License

Original project material is licensed under [CC BY-NC-SA 4.0](LICENSE.md). The unicorn outline adapts Sofie Ascherl's OpenMoji illustration and retains its CC BY-SA 4.0 license. [Original illustration](https://openmoji.org/library/emoji-1F984/) · [Artwork license](https://creativecommons.org/licenses/by-sa/4.0/)
