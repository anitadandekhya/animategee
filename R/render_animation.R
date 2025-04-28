#' Render and Save Animation
#'
#' Saves a `gganimate` object to a GIF, MP4 file or interactive HTML.
#'
#' @param animation (gganimate object) Animation created by `animate_ts()`.
#' @param output (Character) Output file path (e.g., "animation.gif").
#' @param type (Character) Export format: "gif", "mp4", or "html" (default: "gif").
#' @param fps (Numeric) Frames per second (default: 10).
#' @param width (Numeric) Width in pixels (default: 800).
#' @param height (Numeric) Height in pixels (default: 600).
#' @return Invisible 'NULL'. Saves file to disk.
#' @examples
#' \dontrun{
#' ndvi_df <- fetch_ts(
#'   collection = "LANDSAT/LC08/C01/T1_8DAY_NDVI",
#'   band = "NDVI",
#'   dates = c("2010-01-01", "2020-12-31")
#' )
#' anim <- animate_ts(ndvi_df, y_col = "NDVI")
#' render_animation(anim, "ndvi.mp4", type = "mp4", fps = 15)
#' }
#' @export
#' @importFrom gganimate animate anim_save gifski_renderer av_renderer
render_animation <- function(animation,
                             output = "animation.gif",
                             type = "gif",
                             fps = 10,
                             width = 800,
                             height = 600) {
  if (!type %in% c("gif", "mp4", "html")) {
    stop("Type must be one of: 'gif', 'mp4', or 'html'")
  }

  if (type == "gif") {
    anim <- gganimate::animate(
      animation,
      fps = fps,
      width = width,
      height = height,
      renderer = gganimate::gifski_renderer(),
      device = "png"
    )
  } else if (type == "mp4") {
    anim <- gganimate::animate(
      animation,
      fps = fps,
      width = width,
      height = height,
      renderer = gganimate::av_renderer()
    )
  } else if (type == "html") {
    anim <- gganimate::animate(
      animation,
      fps = fps,
      width = width,
      height = height
    )
    htmlwidgets::saveWidget(anim, output)
    return(invisible(NULL))
  }

  gganimate::anim_save(output, animation = anim)
  return(invisible(NULL))
}
