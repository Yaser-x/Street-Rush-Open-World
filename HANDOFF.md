# STREET RUSH — development handoff

Updated: 2026-11-16

## Repository
- Repository: Yaser-x/Street-Rush-Open-World
- Working branch: prototype/godot-3d-foundation
- Main branch remains untouched.
- Base commit for current CI correction: 1c09bea6123c8779a7448b03905091e8c7985616

## Current milestone
Phase 1 Android-first driving prototype. Godot 4.7.2, Mobile renderer, landscape orientation, procedural coastal test district, physics-driven placeholder car, third-person follow camera, touch driving HUD, keyboard controls, speedometer, pause/resume.

## Implemented source
- Car spawn height aligned with road surface.
- Chassis friction set to 0.55 so engine force overcomes contact friction.
- Vehicle controller includes forward/reverse speed limiting, speed-sensitive steering, lateral grip, drag, downforce, braking and handbrake grip reduction.
- Touch HUD includes steering, reverse, handbrake, brake, accelerator and pause.
- Automated smoke test verifies scene startup, vehicle spawn, HUD input propagation, acceleration and braking.
- No crash-triggered vibration/haptic code.

## Verification record
- GitHub Actions run #10, commit e6e3b5632dac0fb5547e9d8ee23aefd092bee42e: SUCCESS. Godot import/parse, main scene launch and driving smoke test all passed. Log: "STREET_RUSH_SMOKE_TEST: PASS | scene, spawn, HUD acceleration, HUD braking".
- Run #11, commit 1c09bea6123c8779a7448b03905091e8c7985616: validation job PASSED including driving smoke test. Android job FAILED during setup-android because the action's default package list includes the obsolete "tools" SDK package.
- The setup-android action has now been configured to install only platform-tools; required SDK packages are installed explicitly in the next step. This fix awaits CI.
- Android APK has NOT been built.
- Physical Android playtest has NOT been performed.
- Procedural 3D blockout assets are placeholders, not production quality.

## Android export configuration
- export_presets.cfg defines "Android Debug", ARM64-v8a only, package com.yaser.streetrushopenworld, version 0.1.0.
- Project enables ETC2/ASTC texture import compression.
- Android CI uses JDK 17, SDK 36/build-tools 36.1.0, Godot 4.7.2 export templates and a temporary debug keystore.
- The job exports a debug APK, verifies ZIP integrity, package identifier and ARM64 native library, then uploads the APK artifact for 7 days.
- No signing key/password is committed. This is a debug build, not a Play Store release.

## Feature status
- Partial foundations: 20 (placeholder passenger car), 25 (prototype driving physics), 58 (third-person camera).
- Phase 1 code and automated smoke test pass CI. Physical touch usability, visuals and Android device test remain pending.
- All remaining approved features remain pending in ROADMAP.md. No feature removed.

## Current blockers
1. Re-run Android CI with the obsolete SDK tools package removed.
2. Verify exported APK and downloadable artifact.
3. Install and test on the physical Realme device; tune driving feel and touch layout.

## Last successful prototype commit
e6e3b5632dac0fb5547e9d8ee23aefd092bee42e (project import, headless scene and driving smoke test all passed).

## Next exact task
Verify Android debug export. Inspect any SDK/template/export errors, fix them, and rerun until a valid ARM64 APK artifact is produced.
