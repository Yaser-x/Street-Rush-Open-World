# STREET RUSH — development handoff

Updated: 2026-11-16

## Repository
- Repository: Yaser-x/Street-Rush-Open-World
- Working branch: prototype/godot-3d-foundation
- Main branch remains untouched.
- Base commit for current physics-material fix: adc0c4e66b9cff4aaea5ffdae5ccc5ed21d77e30

## Current milestone
Phase 1 driving foundation: Godot 4.7.2-targeted Mobile project with procedural coastal blockout, physics-driven placeholder car, third-person camera, touch HUD, keyboard input and pause/resume. Placeholder geometry only.

## Source implementation
- Car spawn height aligned to the road surface.
- Vehicle controller includes forward/reverse speed limits, speed-sensitive steering, lateral grip, drag, downforce, braking and handbrake grip reduction.
- Added a normal-scene automated smoke test for main scene, vehicle spawn, HUD input, acceleration and braking.
- Added reduced-friction physics material to the placeholder car chassis (friction 0.55) so its engine force can overcome contact friction. This was identified by Run #9 diagnostics; verification pending.
- No crash-triggered vibration/haptic code included.

## Test diagnosis and history
- Runs #1–#6: Godot project import and headless main-scene launch succeeded.
- Run #7: import/launch passed; smoke test failed because test bypassed HUD input.
- Run #8: import/launch passed; smoke test still failed because test ran in SceneTree script mode.
- Run #9: regular Node test scene and HUD-to-controller input propagation passed; acceleration still measured 0.00 m/s. Diagnostics pointed to the car remaining stationary despite throttle reaching the controller. Static friction from the default chassis collision material was identified as the likely cause.
- Current commit applies a lower-friction chassis material. Awaiting Run #10 verification.

## Feature status
- Partial foundations: 20 (placeholder passenger car), 25 (prototype driving physics), 58 (third-person camera).
- Remaining approved features are tracked as pending in ROADMAP.md. None removed.
- Android APK not built.
- Physical Android playtest not performed.
- Procedural blockout assets are not production models.

## Android export research
- Official Godot export requires matching export templates, Android SDK and Java SDK paths in editor settings. JDK 17 is recommended for manual setup.
- Plan: debug APK, ARM64 first, no paid services or release keystore.
- Export preset and build workflow are not yet committed.

## Last known passing commit
bc3e4387664d53d1c5d30cfca8057ff6bef39247 for import and headless main-scene launch. Later commits have not yet passed the new driving smoke test.

## Current blockers
1. Verify the new chassis friction setting and smoke test.
2. Configure Android SDK/JDK, export templates and editor settings in CI.
3. Physical device playtest and driving feel tuning remain pending.

## Next exact task
Confirm the vehicle accelerates and brakes in the smoke test. Then add the Android debug export preset and CI APK build, verifying the artifact and APK package contents.
