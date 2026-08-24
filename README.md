# meesSpatialEcology

Local `learnr` tutorials for MEES 698C (Spatial Ecology in R). Replaces the shinyapps.io-hosted
versions of these tutorials, which slowed down or failed under concurrent student use.

## Install (one time, or whenever tutorials are updated)

```r
install.packages("remotes")
remotes::install_github("fitzLab-AL/spatialEcology", subdir = "meesSpatialEcology")
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

**Why not `learnr::run_tutorial()`, and why `source()` instead of an exported function:**
`learnr::run_tutorial()` fails on any tutorial that plots a raw `terra` raster
(`Introduction-to-Rasters`, `CRS-and-Spatial-Transformation`, `Advanced-Spatial-Data-in-R`) with
`Error in 'plot.xy()':
invalid type passed to graphics function`, aborting the prerender before the app ever launches
(exit code 0 - not a crash, just a silent stop). The actual trigger isn't `learnr::run_tutorial()`
specifically - it's calling `rmarkdown::run()` from *inside an installed package's namespace*.
An earlier version of this helper was an exported `meesSpatialEcology::run_tutorial()` function,
which hit the exact same failure for the same reason. Sourcing `inst/run_tutorial.R` instead
defines the function in your own environment rather than a package namespace, which has been
100% reliable in testing across all three tutorials. Root cause of the namespace-vs-global-env
difference not identified despite extensive comparison (identical call arguments, search path,
and knitr options at the point of failure). If this gets root-caused or fixed upstream, this
workaround and note can come out.

## Running out of compute

Some tutorials/exercises can be slow on older laptops. If something is taking too long to run
locally, try: fewer iterations/simulations, a coarser raster resolution, or a smaller subset of
the input data before re-running the exercise. (TODO: expand this into a proper student-facing
guide - noted in course planning memory as still needed.)
