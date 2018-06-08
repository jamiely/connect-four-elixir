# ConnectFour

[![Build Status](https://travis-ci.org/jamiely/connect-four-elixir.svg?branch=master)](https://travis-ci.org/jamiely/connect-four-elixir)

Connect four game written in elixir.


# Building

```bash
mix escript.build
```

Will produce a file `connectfour`. Which you can then run like:

```bash
./connectfour
```

# Testing

```bash
mix test
```

# Docs

Assuming you have [ex_doc](https://github.com/elixir-lang/ex_doc) installed:

```bash
mix compile
ex_doc connectfour 0.1.0 _build/dev/lib/connectfour/ebin
```
