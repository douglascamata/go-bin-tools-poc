# Binary tools from Go source

This repository is a small experiment to install binary tools from Go source code
and integrate them with a Makefile.

## Context

Some time ago, there was no `go install`. Installing dependencies from Go source
code meant you had a few options:

* Clone the repository and `go build` it yourself.
* Download binaries from releases, if there are any with binaries attached
  to the release that were compiled for your OS and CPU architecture.
* Maintain a Go file that imports the binary tools and use a build tag.

All of these options have their own pros and cons. **It's not the purpose of the
PoC to compare them**.

## Purpose

The purpose of the PoC is to show that `go install` is very capable and can be
used to install Go binary tools in any project. It includes the following
features:

* Versioning: tools are versioned with the same capabilities as `go install`.
  This means it supports: git commit hash, git tag, git branch, Go module version,
  etc. It also supports automatic toolchain selection if the system runs Go >= 1.21.
  `go install` can be ran **all the time** and exits quickly if the binary already
  exists and the version matches -- recompilation only happens when the version
  changes.
* Local and independent: tools are installed into a local directory dedicated to
  them and won't interfere with anything outside of it, including the
  `go.{sum|mod}` files (if you have them). Your system stays clean.
* Easy to use: it's easily integrated with makefiles. The version is controlled
  in a single place: a simple variable. There's no need to remember anything to
  upgrade or downgrade a tool besides the desired version.
