#' Fetch Time-Series Data from Google Earth Engine
#'
#' Extracts a time series of a specified band over a region from a GEE collection.
#'
#' @param collection GEE dataset ID. Options:
#'   - Landsat NDVI: "LANDSAT/LC08/C01/T1_8DAY_NDVI"
#'   - MODIS NDVI: "MODIS/006/MOD13A2"
#'   - Sentinel-2: "COPERNICUS/S2_SR"
#' @param band Band name (e.g., "NDVI", "B4", "NDWI").
#' @param region Spatial region to analyze (sf object for EE Geometry).
#' @param dates Start and end dates in "YYYY-MM-DD" format..
#' @param reducer Statistic to compute over the region: "mean", "median", "min", "max" (default: "mean").
#' @param scale Pixel resolution in meters (e.g., 30 for Landsat, 500 for MODIS).
#' @return A dataframe with columns 'date' (timestamp) and 'value' (extracted band values).
#' @examples
#' \dontrun{
#' # Get NDVI from Landsat 8
#' library(sf)
#' gee_init()
#' region <- st_as_sfc("POLYGON ((-110.8 30.2, -110.6 30.2, -110.6 30.4, -110.8 30.4, -110.8 30.2))")
#' ndvi_df<- fetch_ts(
#'   collection = "LANDSAT/LC08/C01/T1_8DAY_NDVI",
#'   band = "NDVI",
#'   region = region,
#'   dates = c("2010-01-01", "2020-12-31"),
#'   scale = 30
#' )
#' head(ndvi_data)
#' }
#' @export
fetch_ts <- function(collection, band, region, dates, reducer = "mean", scale = 30) {
  # Validate inputs
  if (!rgee::ee_check()) stop("GEE not initialized. Run gee_init().")

  # Convert region to EE Geometry if it's an sf object
  if (inherits(region, c("sf", "sfc"))) {
    region <- rgee::sf_as_ee(region)
  }
  # Convert dates to GEE format
  start_date <- rgee::ee$Date(dates[1])
  end_date <- rgee::ee$Date(dates[2])

  # Filter collection
  ee_collection <- rgee::ee$ImageCollection(collection)$
    filterDate(start_date, end_date)$
    select(band)

  # Apply reducer (e.g., mean over region)
  ee_reduced <- ee_collection$map(
    function(image) {
      image$reduceRegion(
        reducer = rgee::ee$Reducer[[reducer]](),
        region = region,
        scale = scale  # Adjust based on dataset
      )
    }
  )

  # Extract values to R dataframe
  df <- rgee::ee_extract(ee_reduced, sf::st_sfc(), fun = NULL)
  return(df)
}
