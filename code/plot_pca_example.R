## example of PCA visulaization
require(ggbiplot)
M[M<=0] <- 1
G <- as.data.frame(t(M))

G$trt <- get_treatemt_type(names(M))
G$day <- get_day(names(M))

log.g <- log(subset(G, select=-c(trt,day)))
g.pca <- prcomp(log.g, center=T, scale=T) # this is recommended 
# g.pca <- prcomp(log.g)

print(g.pca)
plot(g.pca, type='l')
summary(g.pca)

g1 <- ggbiplot(g.pca, obs.scale = 1, var.scale = 1,
               groups = G$trt, ellipse = TRUE,
               circle = F, var.axes=F)
g1 <- g1 + geom_point(aes(shape=G$day, color=G$trt), size=4)
g1 <- g1 + theme(legend.direction = 'vertical', legend.position = 'right')
g1 <- g1 + scale_color_discrete(name = '') + theme(legend.title=element_blank())
g1 <- g1 + ggtitle("Yusa normalized read counts")
print(g1)

ggsave(g1, file="foo.png")
