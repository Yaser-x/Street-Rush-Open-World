# STREET RUSH — development handoff

Updated: 2026-11-16

## Repository
- Repository: Yaser-x/Street-Rush-Open-World
- Working branch: prototype/godot-3d-foundation
- Main branch has not been modified.
- Latest verified branch head before this change: bc3e4387664d53d1c5d30cfca8057ff6bef39247

## Current milestone
Phase 1 driving foundation. A Godot 4.7.2-targeted Mobile-renderer project with a procedural coastal test district, physics-based placeholder car, third-person camera, touch HUD, keyboard input and pause/resume. This is still a prototype blockout, not production content.

## Latest source improvements in this change
- Corrected car spawn height: the road surface is at y=0.05 and the car collision bottom now aligns with it at spawn.
- Reworked arcade driving forces: forward/reverse speed limits, steering torque based on speed, lateral grip, aerodynamic drag, downforce, service brake and handbrake grip reduction.
- Added tests/prototype_smoke_test.gd to instantiate the main scene and verify vehicle creation, spawn height, forward acceleration and braking.
- Added the smoke test to GitHub Actions after import and headless scene launch.
- No crash-triggered vibration or haptic code is included.

## Feature status
- Partial foundations: 20 (one procedural passenger-car placeholder), 25 (prototype driving physics), 58 (third-person camera only).
- Phase 1 still needs visual tuning and physical Android testing.
- All other approved features remain pending and tracked in ROADMAP.md. No feature removed.

## Verification
- GitHub Actions runs #1 through #6 succeeded for their respective commits.
- Run #6, commit bc3e4387664d53d1c5d30cfca8057ff6bef39247: Godot import/parse and headless main-scene launch passed.
- The new spawn/acceleration/braking smoke test has been added in this commit but is NOT YET VERIFIED until the new workflow completes.
- Android APK: not built.
- Physical device playtest: not performed.
- Procedural meshes are placeholder blockout geometry.

## Build
Open the repository root in Godot 4.7.2 Stable and run res://scenes/main.tscn. Android export still requires a configured Android SDK/JDK, Godot export templates, package identity and signing setup.

## Last known successful commit
bc3e4387664d53d1c5d30cfca8057ff6bef39247 (previous CI-tested branch head).

## Current blockers
1. New automated driving smoke test awaits CI result.
2. Android SDK/JDK, export templates and signing setup are not yet configured/verified.
3. No physical Realme device testing has been performed.

## Next exact task
Inspect the new CI run. Fix any smoke-test or parser errors before proceeding. Then configure Android export and attempt a reproducible APK build in CI.
