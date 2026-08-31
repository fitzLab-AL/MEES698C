# Source this file, then call run_tutorial("<name>") for any tutorial in the package:
#   source(system.file("run_tutorial.R", package = "meesSpatialEcology"))
#   run_tutorial("Introduction-to-Rasters")
#
# Deliberately NOT an exported package function - calling rmarkdown::run() from inside an
# installed package's namespace (as learnr::run_tutorial() itself does) triggers
# "Error in `plot.xy()`: invalid type passed to graphics function" on any tutorial that
# plots a raw terra raster. Sourcing this file defines run_tutorial() in your own
# environment instead, which does not hit that bug.
run_tutorial <- function(name, launch.browser = TRUE) {
  tutorial_dir <- system.file("tutorials", name, package = "meesSpatialEcology")
  if (!nzchar(tutorial_dir)) {
    stop(
      "Tutorial '", name, "' not found. Available tutorials:\n",
      paste(list.files(system.file("tutorials", package = "meesSpatialEcology")), collapse = ", ")
    )
  }
  rmarkdown::run(
    file.path(tutorial_dir, paste0(name, ".Rmd")),
    shiny_args = list(launch.browser = launch.browser)
  )
}
