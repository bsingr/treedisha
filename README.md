# Treedisha

diffing filesystem-trees using sha1-checksums

## Description

Treedisha is a little ruby gem for comparing two file trees.
like git, it uses sha1-checksums to differentiate files from each other and it also doesn't rely on directories. (actually, i was using a wrapper around git for the same job, before i wrote this)

after comparing the two file trees, it should provide the following information:

* files that weren't changed
* files that were moved (from path => to path)
* files that were modified (from sha1 => to sha1)
* files that were created
* files that were deleted

## License

Treedisha is covered by the MIT License. See LICENSE for more information.