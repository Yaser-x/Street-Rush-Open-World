# STREET RUSH — development handoff

Updated: 2026-11-16

## Repository
- Repository: Yaser-x/Street-Rush-Open-World
- Working branch: prototype/godot-3d-foundation
- Main branch remains untouched.
- Base commit for this correction: 5c863f6f398944e74b13443b5df079719c174c76

## Current milestone
Phase 1 driving foundation: Godot 4.7.2-targeted Mobile project with procedural coastal blockout, physics-driven placeholder car, third-person camera, touch HUD, keyboard input and pause/resume. Placeholder geometry only.

## Source improvements already committed
- Car spawn height aligned with road surface.
- Vehicle force model now includes forward/reverse speed limits, speed-sensitive steering, lateral grip, drag, downforce, braking and handbrake grip reduction.
- A smoke test was added for main scene, vehicle spawn, HUD input, acceleration and braking.

## Test diagnosis
- Run #7 passed project import and headless main scene but failed acceleration check because the initial test bypassed the HUD input path.
- Run #8 also failed acceleration check even after setting HUD controls; the test was running in SceneTree script mode rather than a normal game scene.
- The test has now been converted to a regular Node scene and asserts physics processing and HUD-to-controller input propagation before checking movement. It prints diagnostic position/velocity/input on failure. Awaiting CI verification.
- These failures are recorded rather than being marked passed.

## Feature status
- Partial foundations: 20 (placeholder passenger car), 25 (prototype driving physics), 58 (third-person camera).
- All remaining approved features are still pending in ROADMAP.md.
- No crash-triggered vibration/haptic code included.

## Verification
- CI runs #1 through #6 passed import and headless main-scene launch.
- Runs #7 and #8 passed import and headless main-scene launch but failed the newly introduced acceleration smoke test.
- Current regular-scene smoke-test correction has not yet been run.
- Android APK not built.
- Physical Android playtest not performed.
- Procedural blockout assets are not final production assets.

## Android export research
- Godot Android export requires matching export templates, Java SDK and Android SDK paths configured in editor settings. Official Godot docs recommend JDK 17 for manual setup.
- Next export workflow will use a debug APK with arm64-v8a enabled. No release signing secret or paid service is required for this prototype debug build.
- Android export is not configured or verified yet.

## Last known passing commit
bc3e4387664d53d1c5d30cfca8057ff6bef39247 for project import and headless main-scene launch. Current branch contains later physics changes whose automated driving test is pending.

## Current blockers
1. Verify regular-scene smoke test and fix actual physics/controller issues if it still fails.
2. Android SDK/JDK/export templates and editor settings need CI configuration.
3. Physical device playtest and tuning remain pending.

## Next exact task
Verify the in-game-loop smoke test. Once it passes, add a debug Android export preset and a CI job to generate an ARM64 APK, then verify the APK artifact exists and is valid.
