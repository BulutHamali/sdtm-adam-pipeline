# 00_get_data.R
# Step 1: Load CDISC Pilot SDTM datasets (admiral.test package)

if (!requireNamespace("admiral.test", quietly = TRUE)) {
  install.packages(
    "admiral.test",
    repos = c("https://pharmaverse.r-universe.dev", "https://cloud.r-project.org")
  )
}

library(admiral.test)
library(dplyr)

# Load example SDTM datasets (DM = Demographics, AE = Adverse Events)
dm <- admiral_dm
ae <- admiral_ae
lb <- admiral_lb

# Check a preview
cat("DM rows:", nrow(dm), "\n")
cat("AE rows:", nrow(ae), "\n")
cat("LB rows:", nrow(lb), "\n")

# Save copies to raw_data for reference (optional)
if (!dir.exists("raw_data")) dir.create("raw_data")
write.csv(dm, "raw_data/dm.csv", row.names = FALSE)
write.csv(ae, "raw_data/ae.csv", row.names = FALSE)
write.csv(lb, "raw_data/lb.csv", row.names = FALSE)

cat("Raw SDTM datasets saved to raw_data/ folder.\n")
