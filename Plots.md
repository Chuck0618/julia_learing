## Plots

- GR后端，JuliaPro Juno和Anaconda3 Jupyter中都成功调用。但Jupyter中用中文标题会有乱码。

- PlotlyJS后端：JuliaPro的Atom-Juno界面使用成功； 在Jupyter中使用，要求安装ORCA包，总是出错。

- PyPlot后端：JuliaPro的Juno中安装测试反复试验后成功。Jupyter笔记本中测试成功。

```julia
add Plots
add GR
add PlotlyJS
add PyPlot
```

### 使用画图工具

```julia
using Plots
gr()##gr 后台
Plots.plot(Plots.fakedata(50, 5), w=3)
```


## julia 图形库

```julia
using Cairo  # c 语言 Cairo 的2D图形库
using Luxor # Cairo的封装，文档地址 http://juliagraphics.github.io/Luxor.jl/stable/explanation/imagematrix/
```