# STREET RUSH — development handoff

Updated: 2026-11-16

## Repository
- Repository: Yaser-x/Street-Rush-Open-World
- Working branch: prototype/godot-3d-foundation
- Main branch remains untouched.
- Last verified branch head before this export setup: e6e3b5632dac0fb5547e9d8ee23aefd092bee42e

## Current milestone
Phase 1 Android-first driving prototype. Godot 4.7.2, Mobile renderer, landscape orientation, procedural coastal test district, physics-driven placeholder car, third-person follow camera, touch driving HUD, keyboard controls, speedometer, pause/resume.

## Implemented source
- Corrected vehicle spawn height to align chassis collision with road surface.
- Reduced placeholder chassis friction to 0.55 so engine force can overcome static contact friction.
- Driving controller includes forward/reverse speed limiting, speed-sensitive steering, lateral grip, aerodynamic drag, downforce, service braking and handbrake grip reduction.
- Touch HUD includes left/right steering, reverse, handbrake, brake, accelerator and pause.
- Automated smoke test verifies main scene, vehicle spawn, HUD throttle propagation, acceleration and braking.
- No crash-triggered vibration/haptic code.

## Verification record
- CI runs #1–#6 passed project import and headless main scene launch.
- Runs #7–#9 exposed smoke-test harness issues and a genuine chassis friction problem. Failures and diagnostics were inspected rather than hidden.
- GitHub Actions run #10, commit e6e3b5632dac0fb5547e9d8ee23aefd092bee42: SUCCESS. Godot import/parse, main-scene launch, and driving smoke test passed. Log output: "STREET_RUSH_SMOKE_TEST: PASS | scene, spawn, HUD acceleration, HUD braking".
- Android APK: NOT YET BUILT.
- Physical Android playtest: NOT PERFORMED.
- Procedural 3D blockout assets are placeholders, not production-quality models.

## Android export configuration added in current commit
- export_presets.cfg defines "Android Debug", ARM64-v8a only, package com.yaser.streetrushopenworld, version 0.1.0.
- Project enables ETC2/ASTC texture import compression for Android readiness.
- GitHub Actions adds an Android build job using JDK 17, Android SDK 36/build-tools 36.1.0, matching Godot 4.7.2 export templates and a temporary debug keystore.
- Job exports a debug APK, checks ZIP integrity, package ID and ARM64 native library presence, then uploads an artifact for 7 days.
- The signing key is generated ephemerally in CI; no keystore/password is committed. This is a debug build, not a Play Store release.
- The new Android workflow has NOT YET completed; export success and APK artifact are unverified.

## Feature status
- Partial foundations: 20 (one placeholder passenger car), 25 (prototype driving physics), 58 (third-person camera only).
- Phase 1 source and automated driving smoke test are implemented. Physical touch usability, visual tuning and device playtest remain pending.
- All other approved features remain pending and tracked in ROADMAP.md. No feature removed.

## Current blockers
1. New Android CI job must complete; any SDK/template/preset errors must be fixed.
2. Physical Realme device installation and driving controls must be tested.
3. Driving feel, camera smoothness and touch control layout need visual tuning.

## Last successful commit
e6e3b5632dac0fb5547e9d8ee23aefd092bee42 (Godot project import, headless main scene and acceleration/braking smoke test all passed).

## Next exact task
Verify the new Android debug APK job. Inspect logs on failure, correct the export toolchain/preset, and rerun. If successful, provide the verified APK artifact and continue Phase 1 device testing.
