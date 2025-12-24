# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - 2024-12-24

### Added
- Initial release as `macula_envy` on hex.pm
- rebar3 build support (original used erlang.mk)
- hex.pm package configuration
- ex_doc documentation support

### Attribution
This is a fork of [shortishly/envy](https://github.com/shortishly/envy) by Peter Morgan.
All credit for the original design and implementation goes to Peter Morgan.

### Changes from original
- Added `rebar.config` for rebar3 compatibility
- Added `macula_envy.app.src` for OTP application spec
- Package published to hex.pm as `macula_envy`
- Module names remain `envy` and `envy_gen` for API compatibility
