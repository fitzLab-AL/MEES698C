# ---------------------------------------------------------------------------
# MEES 698C - Spatial Ecology in R
# Install the R packages used in the course
#
# Safe to re-run at any point in the semester: packages you already have are
# skipped, so only what's actually missing gets installed.
# ---------------------------------------------------------------------------

# Install only the packages that aren't already available.
install_if_missing <- function(pkgs) {
  have <- vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)
  if (any(!have)) {
    install.packages(pkgs[!have])
  }
  if (any(have)) {
    message("Already installed, skipping: ", paste(pkgs[have], collapse = ", "))
  }
  invisible(pkgs[!have])
}

# core: spatial data, plotting, and the tutorial engine
install_if_missing(c("sf",
                     "terra",
                     "dplyr",
                     "ggplot2",
                     "geodata",
                     "tmap",
                     "rnaturalearth",
                     "rnaturalearthdata",
                     "learnr",
                     "remotes"))

# gradethis is not on CRAN - install from GitHub
if (!requireNamespace("gradethis", quietly = TRUE)) {
  remotes::install_github("rstudio/gradethis")
} else {
  message("Already installed, skipping: gradethis")
}

# homework 1
install_if_missing(c("daymetr", "tidygeocoder"))

# coding assignment 2 - plotting
install_if_missing("colorRamps")

# coding assignment 3 - spatial autocorrelation (correlograms, variograms);
# kriging is used in the Scale & Spatial Structure tutorial
install_if_missing(c("gstat", "ncf", "kriging"))

# coding assignment 4 - point pattern analysis
install_if_missing("spatstat")

# coding assignment 5 - species distribution models
# note: viridisLite already arrives as a ggplot2 dependency, but the
# assignments call library(viridisLite) directly, so install it explicitly
install_if_missing(c("dismo", "predicts", "usdm", "tidyterra", "viridisLite",
                     "maxnet", "blockCV", "ecospat", "randomForest", "gbm"))

# course package - interactive tutorials for MEES 698C
# (always run: install_github() skips the download itself when the installed
# version already matches the one on GitHub, so this only acts when there are
# new/updated tutorials)
remotes::install_github("fitzLab-AL/MEES698C", upgrade = "never")
