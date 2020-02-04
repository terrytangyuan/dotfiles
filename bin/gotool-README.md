# gotool

by ohmystack (jiangjun1990@gmail.com)

`gotool` is a command-line tool for Golang to help the developer to source the workspace, and unsource it.

It is greatly inspired by the `virtualenv` from Python.

But here is only a small script. Cool, right?

Feature
=======

* Activate/deactivate the current path as a `$GOPATH`
* Add the relevant 'bin' directory into `$PATH`
* Auto detect Godeps path
* Colorful `$PS1` support for zsh

We will have more feature in the future. Please tell me if you have a good idea.

Installation
============

```bash
$ cp gotool /usr/local/bin/gotool
```

Usage
=====

```bash
$ gotool -h
Golang Developer Tool
Usage: source gotool [a|activate] [d|deactivate|exit]
```

#### Activate

Activate current path, adding it into `$GOPATH` and its `./bin` into `$PATH`.

```bash
cd <your-workspace>
source gotool activate

# OR use 'a' for short
source gotool a
```

Done!

You will see a prefix, the name of this directory, in front of your PS1.
If the path is under `Godeps/_workspace/`, the prefix will be the project name.

Then, you can check your `$GOPATH` and `$PATH`.

#### Deactivate

```bash
source gotool deactivate

# OR use 'd' for short
source gotool d

# OR
source gotool exit
```
