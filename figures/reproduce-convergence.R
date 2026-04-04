#!/usr/bin/env Rscript
## Reproduce the convergence before/after figure from the paper

library(ggplot2)

df <- data.frame(
  Component = rep(c("Unit FE", "Factors", "Variance"), each = 2),
  Period    = rep(c("Before", "After"), 3),
  Error     = c(2.03e-1, 3.72e-3, 2.99, 6.89e-2, 5.07e-3, 2.25e-6)
)
df$Component <- factor(df$Component,
                       levels = c("Unit FE", "Factors", "Variance"))
df$Period <- factor(df$Period, levels = c("Before", "After"))

p <- ggplot(df, aes(x = Component, y = Error, fill = Period)) +
  geom_col(position = "dodge", width = 0.6) +
  scale_y_log10(labels = scales::scientific) +
  scale_fill_manual(values = c(Before = "#d73027", After = "#4575b4")) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "bottom",
        panel.grid.minor = element_blank()) +
  labs(y = "Relative Error (log scale)", x = NULL,
       title = "EM Convergence: Before vs. After Fix") +
  annotate("text", x = 1, y = 0.15,   label = "55x",   size = 3.5, fontface = "bold") +
  annotate("text", x = 2, y = 2.2,    label = "43x",   size = 3.5, fontface = "bold") +
  annotate("text", x = 3, y = 3.8e-3, label = "2249x", size = 3.5, fontface = "bold")

ggsave("figures/fect-convergence.png", p, width = 6, height = 4, dpi = 300)
cat("Figure saved to figures/fect-convergence.png\n")
