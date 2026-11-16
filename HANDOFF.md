# STREET RUSH — development handoff

Updated: 2026-11-16

## Repository
- Repository: Yaser-x/Street-Rush-Open-World
- Working branch: prototype/godot-3d-foundation
- Main branch has not been modified.
- Current base before this test correction: 8581abeb36fba54fbaface8cc5c46618e341a30c

## Current milestone
Phase 1 driving foundation: Godot 4.7.2-targeted Mobile project with procedural coastal blockout, physics-driven car, third-person camera, touch HUD, keyboard input and pause/resume. Prototype geometry only.

## Implemented in latest source commit
- Corrected car spawn height to align collision shape with road surface.
- Reworked driving force model: forward/reverse speed limiting, steering torque, lateral grip, aerodynamic drag, downforce, braking and handbrake grip reduction.
- Added headless smoke test for main scene, vehicle spawn, acceleration and braking.
- First smoke-test run FAILED because the test directly called vehicle input while the active HUD correctly overwrote it each frame. This was a test harness error, not evidence of working driving.
- Updated smoke test to operate the actual HUD control path for accelerator and brake. This correction awaits CI verification.
- No crash-triggered vibration/haptic code is included.

## Feature status
- Partial foundations: 20 (placeholder passenger car), 25 (prototype driving physics), 58 (third-person camera).
- Other approved features remain pending and tracked in ROADMAP.md. No approved feature removed.
- Phase 1 requires successful automated driving test, visual tuning and Android device test.

## Verification
- Prior Godot CI runs #1 through #6 passed project import and headless main scene launch.
- Run #7, commit 8581abeb36fba54fbaface8cc5c46618e341a30c: project import and headless main scene passed; new smoke test failed because test bypassed HUD input and HUD reset the vehicle command each frame.
- Smoke test now uses HUD's same control path as touch buttons. Awaiting next CI run.
- Android APK: not built.
- Physical Android playtest: not performed.
- Assets remain procedural placeholders.

## Build
Open the repository root in Godot 4.7.2 Stable and run res://scenes/main.tscn. Android export still needs SDK/JDK, export templates, package identity and signing configuration.

## Last known passing commit
bc3e4387664d53d1c5d30cfca8057ff6bef39247 for previous project/headless scene tests. Run #7 passed scene launch but failed new driving smoke test.

## Current blockers
1. HUD-driven smoke test correction needs CI confirmation.
2. Android export toolchain and signing configuration are not configured.
3. Physical device playtest and driving feel tuning remain pending.

## Next exact task
Verify corrected smoke test in GitHub Actions; inspect and fix any actual runtime or physics issue. Then investigate Android export runner setup and produce a reproducible APK build.
