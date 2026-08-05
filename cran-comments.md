## Submission

This is a patch update of r4subdata from 0.1.1 (on CRAN) to 0.1.3. It clarifies
the package DESCRIPTION wording ("R4SUB" expands to "Ready for Submission") and
carries the example datasets used across the R4SUB ecosystem. No datasets or
interfaces were removed or changed incompatibly. See NEWS.md.

## Test environments

* local: Windows 11 x64, R 4.5.x
* GitHub Actions: ubuntu-latest, windows-latest, macos-latest (R release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

r4subdata is a data-only package. It is suggested by several R4SUB packages and
imported by the r4sub meta-package; the changes are documentation-only.
