# 03_summary_adae.R
# Step 4: Summarize ADAE (Adverse Events)

library(readr)
library(dplyr)
library(ggplot2)

# Load ADAE
adae <- read_csv("adam/adae.csv", show_col_types = FALSE)

# Create summary: subjects with ≥1 AE by treatment arm
summary_ae <- adae %>%
  group_by(TRT_FLAG) %>%
  summarise(N_Subjects = n_distinct(USUBJID), .groups = "drop")

# Save summary table
if (!dir.exists("tlf")) dir.create("tlf")
write_csv(summary_ae, "tlf/ae_summary_by_treatment.csv")

cat("AE summary table saved to tlf/ae_summary_by_treatment.csv\n")

# Create bar chart 
plot <- ggplot(summary_ae, aes(x = TRT_FLAG, y = N_Subjects, fill = TRT_FLAG)) +
  geom_bar(stat = "identity") +
  labs(title = "Subjects with ≥1 Adverse Event by Treatment Arm",
       x = "Treatment Group", y = "Number of Subjects") +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "white")
  )

ggsave("tlf/ae_summary_plot.png", plot, width = 6, height = 4, bg = "white")

