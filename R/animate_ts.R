#' Animate Time-Series Data
#'
#' Creates a customizable animation using `ggplot2` and `gganimate`.
#'
#' @param df (Dataframe) Time-series data from `fetch_ts()`.
#' @param x_col (Character) Name of the column containing timestamps (default: "date").
#' @param y_col (Character) Name of the column with values to plot (default: "value").
#' @param color (Character) Line color (default: "blue").
#' @param title (Character) Plot title (default: "Time Series Animation").
#' @return A `gganimate` object.
#' @examples
#' \dontrun{
#' ndvi_df<- fetch_ts(
#'   collection = "LANDSAT/LC08/C01/T1_8DAY_NDVI",
#'   band = "NDVI",
#'   region = region,
#'   dates = c("2010-01-01", "2020-12-31"),
#'   scale = 30
#' )
#' anim <- animate_ts(ndvi_df, y_col = "NDVI", color = "red", title = "NDVI Trends( 2010-2020")
#' render_animation(anim, "ndvi_trends.gif")
#' }
#' @export
animate_ts <- function(df, x_col = "date", y_col = "value",
                       color = "blue", title = "Time Series Animation") {
  p <- ggplot2::ggplot(df, ggplot2::aes_string(x = x_col, y = y_col)) +
    ggplot2::geom_line(color = color, size = 1) +
    ggplot2::labs(title = title) +
    gganimate::transition_reveal(!!rlang::sym(x_col))

  return(p)
}
