# 04_summary_adsl.R
# Step 5: Summarize ADSL (Demographics)

library(readr)
library(dplyr)
library(ggplot2)

# Load ADSL (subject-level dataset)
adsl <- read_csv("adam/adsl.csv", show_col_types = FALSE)

# Create summary: Age group & Sex by treatment arm
demo_summary <- adsl %>%
  group_by(TRT_FLAG, AGEGRP, SEX) %>%
  summarise(N = n_distinct(USUBJID), .groups = "drop")

# Save summary table
if (!dir.exists("tlf")) dir.create("tlf")
write_csv(demo_summary, "tlf/demographics_summary.csv")

cat("Demographics summary table saved to tlf/demographics_summary.csv\n")

# Create stacked bar chart (Age Groups, colored by Sex)
plot <- ggplot(demo_summary, aes(x = AGEGRP, y = N, fill = SEX)) +
  geom_bar(stat = "identity", position = "stack") +
  facet_wrap(~TRT_FLAG) +
  labs(title = "Demographics by Age Group and Sex",
       x = "Age Group", y = "Number of Subjects") +
  theme_minimal()

ggsave("tlf/demographics_plot.png", plot, width = 7, height = 5)

cat("Demographics plot saved to tlf/demographics_plot.png\n")
