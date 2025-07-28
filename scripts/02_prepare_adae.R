# 02_prepare_adae.R
# Step 3: Create ADAE (Analysis Dataset for Adverse Events)

library(readr)
library(dplyr)

# Load SDTM AE and ADSL
ae <- read_csv("raw_data/ae.csv", show_col_types = FALSE)
adsl <- read_csv("adam/adsl.csv", show_col_types = FALSE)

# Make sure RFSTDTC exists by pulling it from ADSL (it’s in DM originally)
adae <- ae %>%
  left_join(
    adsl %>% select(USUBJID, ARM, TRT_FLAG, AGEGRP, RFSTDTC),
    by = "USUBJID"
  ) %>%
  mutate(
    TEAE_FLAG = if_else(!is.na(AESTDTC) & !is.na(RFSTDTC) & AESTDTC >= RFSTDTC, "Y", "N")
  )

# Save ADAE dataset
if (!dir.exists("adam")) dir.create("adam")
write_csv(adae, "adam/adae.csv")

cat("ADAE dataset created with", nrow(adae), "rows.\n")
