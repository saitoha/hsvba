hsvba
======
A CLI tool for analyzing VBA macros. See the header comment block in the
[source code](https://github.com/saitoha/hsvba/blob/main/hsvba) for details.

## License and Attributions

This project is licensed under **GPL-3.0-only**.
See the full text in [`LICENCE`](./LICENCE).

Portions of the code are derived from the
[libvisio](https://wiki.documentfoundation.org/DLP/Libraries/libvisio)
project (licensed under **MPL-2.0**) and have been relicensed to **GPL-3.0-only**
under the "Secondary License" permission in **MPL-2.0 section 3.3**.

Portions are also derived from
[bontchev/pcodedmp](https://github.com/bontchev/pcodedmp) (licensed under
**GPL-3.0**; see upstream for "only" vs "or-later"). These portions are included
here under **GPL-3.0-only** for project-wide consistency.

**Scope:** upstream-derived logic is interleaved inside the AWK script
(implementing multiple modules, e.g., `vba::vsd` and `pcdoe`).
In the source, derived regions are marked with inline guards:

```text
# BEGIN: libvisio-derived (MPL-2.0), file <name>, commit <abc123>
# ...
# END: libvisio-derived
# BEGIN: pcodedmp-derived (GPL-3.0), file <name>, commit <def456>
# ...
# END: pcodedmp-derived
```

Notes

- Original upstream copyright and notice lines are preserved.

- No libvisio files marked "Incompatible With Secondary Licenses" were used.

**Third-party component: gitlog-to-changelog**

The script located at `scripts/gitlog-to-changelog` originates from the
GNOME libgee project, where it is distributed under GPL-3.0-or-later.
We keep its original license header; this does not change the project-wide
license (GPL-3.0-only).
