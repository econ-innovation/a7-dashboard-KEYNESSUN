library(ggplot2)
library(plotly)
library(DT)
library(htmlwidgets) 

data <- read.csv("data/pub_211.csv", stringsAsFactors = FALSE)

# 创建散点图并保存为图片
scatterPlot <- ggplot(data, aes(x = pubyear, y = totaljif, color = inst_cn)) +
  geom_point() +
  theme_minimal() +
  labs(title = "年份与影响因子的关系", x = "年份", y = "影响因子")
ggsave("scatterPlot.png", plot = scatterPlot)

# 创建动态图并保存为HTML
dynamicPlot <- ggplot(data, aes(x = pubyear, y = totaljif, color = inst_cn, frame = pubyear)) +
  geom_point() +
  labs(title = "年份与影响因子的动态关系", x = "年份", y = "影响因子") +
  theme_minimal()
dynamicPlotly <- ggplotly(dynamicPlot)
htmlwidgets::saveWidget(dynamicPlotly, "dynamicPlot.html")

# 创建交互图并保存为HTML
interactivePlot <- plot_ly(data, x = ~pubyear, y = ~totaljif, type = 'scatter', mode = 'markers', text = ~inst_cn)
htmlwidgets::saveWidget(interactivePlot, "interactivePlot.html")

# 创建表格并保存为HTML
dataTable <- datatable(data, options = list(pageLength = 10))
htmlwidgets::saveWidget(dataTable, "dataTable.html")