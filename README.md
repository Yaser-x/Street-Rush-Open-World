# STREET RUSH: OPEN WORLD

An original Android-first 3D open-world driving and life-simulation game.

## Technology
- Godot 4.7.2 Stable target
- GDScript, 3D, Mobile renderer
- Android landscape first; desktop keyboard input is retained for development/testing
- Original procedural blockout assets; no copied GTA/Rockstar content
- No crash-triggered vibration or haptics

## Phase 1 prototype
The current foundation contains a small fictional coastal-city test block, a physics-driven player car, chase camera, touch driving HUD, keyboard controls, speed readout, collision geometry, and pause/resume.

## Open in Godot
1. Download/open this repository in Godot 4.7.2 Stable.
2. Import the project by selecting the repository root (the folder containing `project.godot`).
3. Run `scenes/main.tscn` or press F6/F5.
4. For Android, install matching Godot export templates and configure the Android SDK/JDK in Editor Settings before exporting.

The Android export preset is a starting configuration, not proof of a signed or installable APK. Configure a release keystore only for release builds.

## Controls
- Keyboard: W/S or Up/Down to accelerate/reverse, A/D or Left/Right to steer, Space for handbrake, Esc to pause.
- Touch: on-screen steering, accelerator, brake/reverse, and handbrake buttons.
- Camera: third-person chase camera follows the vehicle.

## Project status
See [ROADMAP.md](ROADMAP.md) for the complete approved 70-feature scope and [HANDOFF.md](HANDOFF.md) for verified progress, tests, blockers, and the next task.
