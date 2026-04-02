#!/usr/bin/env Rscript
## Reproduce the democracy effect figure from the paper
## Data: hh2019 (shipped with fect package)
## Reference: Hainmueller & Hangartner (2019), AJPS 63(3):530-547
## Method: Two-way FE (most parsimonious; tightest CIs)

library(fect)

data(hh2019, package = "fect")

out <- fect(nat_rate_ord ~ indirect,
            data = hh2019, index = c("bfs", "year"),
            method = "fe", force = "two-way",
            se = TRUE, nboots = 500, parallel = FALSE)

png("figures/fect-democracy.png", width = 8, height = 5.5,
    units = "in", res = 300)
plot(out,
     main  = "The Effect of Indirect Democracy (Two-Way FE)",
     ylab  = "Effect on nat_rate_ord",
     xlab  = "Time Since the Treatment's Onset",
     stats = "none",
     show.points  = TRUE,
     connected    = TRUE,
     show.count   = TRUE,
     pre.color    = "grey50",
     post.color   = "#1f78b4",
     count.color  = "#e6a817",
     count.alpha  = 0.9)
dev.off()

cat("Figure saved to figures/fect-democracy.png\n")
