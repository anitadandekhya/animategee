#' Initialize Google Earth Engine (GEE)
#'
#' Authenticates and initializes the GEE Python API session using 'rgee'.
#' @note Before using this function, ensure 'rgee' is installed and configured:
#' \preformatted{
#' if (!requireNamespace("rgee", quietly = TRUE)) {
#'   install.packages("rgee")
#'   rgee::ee_install()
#' }
#' }
#'
#' @param email (Optional) GEE-associated email for aunthetication. If "NULL", uses default credentials.
#' @param drive (Logical) Enable Google Drive access.
#' @param gcs (Logical) Enable Google Cloud Storage access.
#' @examples
#' \dontrun{
#' gee_init()  # Default initialization
#' gee_init(email = "your@email.com", drive = TRUE)  # With Drive access
#' }
#' @export
#' @importFrom rgee ee_Initialize
gee_init <- function(email = NULL, drive = FALSE, gcs = FALSE) {
  ee_Initialize(email = email, drive = drive, gcs = gcs)
}
