# Source this file, then call run_tutorial("<name>") for any tutorial in the package:
#   source(system.file("run_tutorial.R", package = "meesSpatialEcology"))
#   run_tutorial("Introduction-to-Rasters")
#
# Deliberately NOT an exported package function - calling rmarkdown::run() from inside an
# installed package's namespace (as learnr::run_tutorial() itself does) triggers
# "Error in `plot.xy()`: invalid type passed to graphics function" on any tutorial that
# plots a raw terra raster. Sourcing this file defines run_tutorial() in your own
# environment instead, which does not hit that bug.
#
# The working directory / tutorial.data_dir dance below is what makes "data/foo.shp" work
# inside exercise chunks. learnr runs each exercise in a fresh temp directory and copies the
# tutorial's data/ folder in first, but it locates that folder relative to the *calling R
# session's* working directory - and rmarkdown::run() never moves into the tutorial
# directory the way shiny::runApp() does for an app.R. Launched from a student's own project
# folder, learnr finds no data/, copies nothing, and every read of "data/..." fails.
run_tutorial <- function(name, launch.browser = TRUE) {
  tutorial_dir <- system.file("tutorials", name, package = "meesSpatialEcology")
  if (!nzchar(tutorial_dir)) {
    stop(
      "Tutorial '", name, "' not found. Available tutorials:\n",
      paste(list.files(system.file("tutorials", package = "meesSpatialEcology")), collapse = ", ")
    )
  }

  # Point learnr at this tutorial's data/ folder explicitly. "" means "no data folder",
  # which is correct for tutorials that ship without one (e.g. Introduction-to-Rasters);
  # a path that does not exist would make learnr abort on the first exercise.
  data_dir <- file.path(tutorial_dir, "data")
  old_opt <- options(tutorial.data_dir = if (dir.exists(data_dir)) data_dir else "")
  on.exit(options(old_opt), add = TRUE)

  # Belt and braces: also run from the tutorial directory, so learnr's own fallback
  # (dir.exists("data")) resolves correctly too.
  old_wd <- setwd(tutorial_dir)
  on.exit(setwd(old_wd), add = TRUE)

  rmarkdown::run(
    file.path(tutorial_dir, paste0(name, ".Rmd")),
    shiny_args = list(launch.browser = launch.browser)
  )
}
