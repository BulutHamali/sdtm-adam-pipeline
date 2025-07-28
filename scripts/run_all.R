# Full pipeline to generate SDTM -> ADaM datasets and recruiter-friendly outputs

cat("Starting SDTM & ADaM portfolio pipeline...\n")

# Step 0: Get SDTM Pilot Study Data
source("scripts/00_get_data.R")

# Step 1: Create ADSL (subject-level dataset)
source("scripts/01_prepare_adsl.R")

# Step 2: Create ADAE (adverse events dataset)
source("scripts/02_prepare_adae.R")

# Step 3: Generate AE summary outputs (table + bar chart)
source("scripts/03_summary_adae.R")

# Step 4: Generate demographics summary outputs (table + stacked bar chart)
source("scripts/04_summary_adsl.R")

cat("\nPipeline complete!\nAll outputs saved to 'adam/' and 'tlf/' folders.\n")
