# Envy

[![Hex.pm](https://img.shields.io/hexpm/v/envy.svg)](https://hex.pm/packages/envy)
[![Hex Docs](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/envy)

**Environment configuration made simple for Erlang/OTP applications.**

This is a rebar3-compatible fork of [shortishly/envy](https://github.com/shortishly/envy), maintained by [macula-io](https://github.com/macula-io) for use in the Macula HTTP/3 mesh platform.

## Attribution

This library was originally created by **Peter Morgan** ([shortishly](https://github.com/shortishly)).

The original implementation provides an elegant solution for unified configuration from OS environment variables and application environment. All credit for the design and core implementation goes to Peter Morgan. This fork adds rebar3/hex.pm packaging support while preserving the original functionality.

**Original Repository:** [github.com/shortishly/envy](https://github.com/shortishly/envy)

## Overview

An OTP application typically gets its configuration using the operating system environment (`os:getenv/1`) and/or application environment (`application:get_env/2`). Both are used to allow configuration to be easily overridden by the OS environment, falling back to defaults provided by the application environment.

Envy is a simple wrapper over both `os:getenv` and `application:get_env` which:

1. **Converts types** naturally returned by `os:getenv` (always string) and `application:get_env` to the type you're expecting
2. **Prefixes OS variables** with the application name, preventing environment clashes

## Installation

Add `envy` to your `rebar.config` dependencies:

```erlang
{deps, [
    {envy, "0.1.0"}
]}.
```

## Usage

### Basic Type Conversion

The result of calling `os:getenv/1` is always a `string()` (or `false` if not present):

```shell
KERNEL_HTTP_PORT=8080 erl
```

```erlang
1> os:getenv("KERNEL_HTTP_PORT").
"8080"
```

Whereas using the application environment:

```shell
erl -kernel http_port 8080
```

```erlang
2> application:get_env(kernel, http_port).
{ok, 8080}
```

### Unified Configuration with Envy

Envy provides type-safe access to configuration from either source:

```shell
cd envy
KERNEL_HTTP_PORT=8080 rebar3 shell
```

```erlang
1> application:set_env(kernel, http_port, 1080).
ok

%% App environment first, then OS environment
2> envy:to_integer(kernel, http_port, [app_env, os_env, {default, 80}]).
1080

%% OS environment first, then app environment
3> envy:to_integer(kernel, http_port, [os_env, app_env, {default, 80}]).
8080
```

### Environment Variable Prefixing

When using the `os_env` strategy, envy automatically prefixes the application name to the environment variable lookup. For `http_port` in the `kernel` application, it looks up `KERNEL_HTTP_PORT`.

### Available Converters

| Function | Return Type | Example |
|----------|-------------|---------|
| `to_integer/3` | `integer()` | `8080` |
| `to_float/3` | `float()` | `3.14` |
| `to_atom/3` | `atom()` | `debug` |
| `to_boolean/3` | `boolean()` | `true` |
| `to_binary/3` | `binary()` | `<<"value">>` |
| `to_list/3` | `list()` | `"value"` |

### Strategy Options

The third argument is a list of strategies tried in order:

| Strategy | Description |
|----------|-------------|
| `os_env` | Look up `{APP}_{KEY}` in OS environment |
| `app_env` | Look up key in application environment |
| `{default, Value}` | Use this value if no other strategy succeeds |

## API Reference

### envy:to_integer/3

```erlang
-spec to_integer(Application :: atom(), Key :: atom(), Strategies :: [strategy()]) -> integer() | undefined.
```

### envy:to_float/3

```erlang
-spec to_float(Application :: atom(), Key :: atom(), Strategies :: [strategy()]) -> float() | undefined.
```

### envy:to_atom/3

```erlang
-spec to_atom(Application :: atom(), Key :: atom(), Strategies :: [strategy()]) -> atom() | undefined.
```

### envy:to_boolean/3

```erlang
-spec to_boolean(Application :: atom(), Key :: atom(), Strategies :: [strategy()]) -> boolean() | undefined.
```

### envy:to_binary/3

```erlang
-spec to_binary(Application :: atom(), Key :: atom(), Strategies :: [strategy()]) -> binary() | undefined.
```

### envy:to_list/3

```erlang
-spec to_list(Application :: atom(), Key :: atom(), Strategies :: [strategy()]) -> list() | undefined.
```

## Dependencies

- [any](https://hex.pm/packages/any) - Type coercion library

## License

Apache-2.0

## Links

- [Original Repository](https://github.com/shortishly/envy) - Peter Morgan's original implementation
- [Macula Platform](https://github.com/macula-io/macula) - HTTP/3 mesh networking platform
- [Hex.pm Package](https://hex.pm/packages/envy)
- [Documentation](https://hexdocs.pm/envy)
