
# animategee

An R package for creating professional animations from Google Earth Engine time-series data with minimal code.

## Installation

You can install the development version of animategee like so:

``` r
remotes::install_github("anitadandekhya/animategee")
```

##  Why Use animategee?

- **Simplified Workflow**: Skip JavaScript/Python and work entirely in R
- **Automated Visualization**: Turn GEE data into animations with 3 functions
- **Reproducible Science**: All processing documented in R scripts
- **Publication-Ready Outputs**: Customize GIFs/MP4s for presentations/papers

## ️ Core Functions
### 1. gee_init()
gee_init() #Authenticates and loads Python dependencies

### 2. fetch_ts()
## Extract time-series data from GEE collections
ndvi <- fetch_ts(
  collection = "MODIS/006/MOD13A2",
  band = "NDVI",
  region = sf::st_as_sfc("POLYGON ((...))"),
  dates = c("2020-01-01", "2020-12-31")
)

### 3. animate_ts() + render_animation()
## Create and export animations
animate_ts(ndvi, title = "NDVI Trends") |> 
  render_animation("output.gif", fps = 10)


### Key Features to Highlight:
1. **"Why Use"**:
   - Emphasize the **R-native** solution (no context switching)
   - Highlight **time savings** (vs manual animation coding)

2. **Comparisons**:
   - Contrast with raw `rgee` (requires more code)
   - Compare to Python alternatives (no Python needed)

3. **Functions**:
   - Show the **end-to-end flow** (init → fetch → animate)
   - Include **visual examples**

---

