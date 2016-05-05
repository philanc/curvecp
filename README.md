
### CurveCP programs

CurveCP was designed by Daniel J. Bernstein (University of Illinois at Chicago).

This implementation is extracted from tinyssh by Jan Mojzís.
https://tinyssh.org/ - https://github.com/janmojzis/tinyssh

It uses tweenacl as a crypto library.

Concepts:  see https://curvecp.org/  and  https://curvecp.org/messageapi.html

Build: run ./build.sh

These programs are intended to be built statically with Musl libc.  The `build.sh` uses the Musl gcc wrapper (see https://www.musl-libc.org/how.html)

Example of use:  see file smoketest.sh

License:  the original DanBernstein's code and the tinyssh by Jan Mojzís are Public Domain. Where public domain does not work, Jan Mojzís proposes a CC0 license (see LICENSE at https://github.com/janmojzis/tinyssh)

All the additions and modifications are also placed in the Public Domain.

Copyright (c) 2016 Phil Leblanc 