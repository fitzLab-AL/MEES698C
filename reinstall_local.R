# Reinstalls meesSpatialEcology from this local folder, for fast local iteration
# while editing. Students should install from GitHub instead (see
# installMEES698packages.R in the parent spatialEcology repo). Run this after
# any edit to a tutorial under inst/tutorials/, then push/commit to
# fitzLab-AL/meesSpatialEcology when the change is ready to share.
remotes::install_local(
  "/Users/mfitzpatrick/code/spatialEcology/meesSpatialEcology",
  force = TRUE
)

learnr::available_tutorials(package = "meesSpatialEcology")
