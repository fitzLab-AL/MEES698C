# meesSpatialEcology

Local `learnr` tutorials for MEES 698C (Spatial Ecology in R).

## Install (one time, or whenever tutorials are updated)

```r
install.packages("remotes")
remotes::install_github("fitzLab-AL/MEES698C")
```

## Run a tutorial

Source the helper once per R session, then the same call works for every tutorial - just swap
the name:

```r
source(system.file("run_tutorial.R", package = "meesSpatialEcology"))

run_tutorial("Introduction-to-Spatial-Vector-Data")
run_tutorial("CRS-and-Spatial-Transformation")
run_tutorial("Introduction-to-Rasters")
run_tutorial("Advanced-Spatial-Data-in-R")
```

This opens the tutorial in your browser or the RStudio Viewer pane, running entirely on your
own machine.

## Running out of compute

Some tutorials/exercises can be slow on older laptops. If something is taking too long to run
locally, try: fewer iterations/simulations, a coarser raster resolution, or a smaller subset of
the input data before re-running the exercise.

## Maintainer note: bump the version on every push

`remotes::install_github()` compares the installed `Version:` in `DESCRIPTION` against the one
on GitHub and **silently skips the install if they match**. Students then think they have the
latest tutorials when they don't.

So: any push that changes a tutorial must also bump `Version:` in `DESCRIPTION` (e.g.
`0.1.1` -> `0.1.2`). Same commit, every time.

The alternative - telling students to run `install_github(..., force = TRUE)` - reinstalls
unconditionally and works without a bump, but it also reinstalls on every run even when nothing
has changed.
