### R code from vignette source 'plm.rnw'

###################################################
### code chunk number 1: plm.rnw:566-567
###################################################
options(prompt= "R> ", useFancyQuotes = FALSE)


###################################################
### code chunk number 2: plm.rnw:570-571
###################################################
library("plm")


###################################################
### code chunk number 3: plm.rnw:581-585
###################################################
data("EmplUK", package="plm")
data("Produc", package="plm")
data("Grunfeld", package="plm")
data("Wages", package="plm")


###################################################
### code chunk number 4: setdata1
###################################################
head(Grunfeld)
E <- pdata.frame(EmplUK, index=c("firm","year"), drop.index=TRUE, row.names=TRUE)
head(E)
head(attr(E, "index"))


###################################################
### code chunk number 5: plm.rnw:617-619
###################################################
summary(E$emp)
head(as.matrix(E$emp))


###################################################
### code chunk number 6: plm.rnw:665-666
###################################################
head(lag(E$emp, 0:2))


###################################################
### code chunk number 7: plm.rnw:675-680
###################################################
head(diff(E$emp), 10)
head(lag(E$emp, 2), 10)
head(Within(E$emp))
head(between(E$emp), 4)
head(Between(E$emp), 10)


###################################################
### code chunk number 8: plm.rnw:698-700
###################################################
emp~wage+capital|lag(wage,1)+capital
emp~wage+capital|.-wage+lag(wage,1)


###################################################
### code chunk number 9: plm.rnw:729-731
###################################################
grun.fe <- plm(inv~value+capital, data = Grunfeld, model = "within")
grun.re <- plm(inv~value+capital, data = Grunfeld, model = "random")


###################################################
### code chunk number 10: plm.rnw:734-735
###################################################
summary(grun.re)


###################################################
### code chunk number 11: plm.rnw:746-747
###################################################
fixef(grun.fe, type = 'dmean')


###################################################
### code chunk number 12: plm.rnw:755-756
###################################################
summary(fixef(grun.fe, type = 'dmean'))


###################################################
### code chunk number 13: plm.rnw:762-764
###################################################
grun.twfe <- plm(inv~value+capital,data=Grunfeld,model="within",effect="twoways")
fixef(grun.twfe,effect="time")


###################################################
### code chunk number 14: plm.rnw:788-790
###################################################
grun.amem <- plm(inv~value+capital, data=Grunfeld,
                 model="random", random.method="amemiya")


###################################################
### code chunk number 15: plm.rnw:797-798
###################################################
ercomp(inv~value+capital, data=Grunfeld, method = "amemiya", effect = "twoways")


###################################################
### code chunk number 16: plm.rnw:814-817
###################################################
grun.tways <- plm(inv~value+capital, data = Grunfeld, effect = "twoways",
                  model = "random", random.method = "amemiya")
summary(grun.tways)


###################################################
### code chunk number 17: hedonic
###################################################
data("Hedonic", package = "plm")
Hed <- plm(mv~crim+zn+indus+chas+nox+rm+age+dis+rad+tax+ptratio+blacks+lstat,
           data = Hedonic, model = "random", index = "townid")
summary(Hed)


###################################################
### code chunk number 18: plm.rnw:863-872
###################################################
data("Crime", package = "plm")
cr <- plm(log(crmrte) ~ log(prbarr) + log(polpc) + log(prbconv) +
         log(prbpris) + log(avgsen) + log(density) + log(wcon) + 
         log(wtuc) + log(wtrd) + log(wfir) + log(wser) + log(wmfg) + 
         log(wfed) + log(wsta) + log(wloc) + log(pctymle) + log(pctmin) + 
         region + smsa + factor(year) | . - log(prbarr) -log(polpc) + 
         log(taxpc) + log(mix), data = Crime,
         model = "random")
summary(cr)


###################################################
### code chunk number 19: plm.rnw:879-884
###################################################
ht <- pht(lwage~wks+south+smsa+married+exp+I(exp^2)+
          bluecol+ind+union+sex+black+ed | 
          sex+black+bluecol+south+smsa+ind,
          data=Wages,index=595)
summary(ht)


###################################################
### code chunk number 20: grunfeld.within
###################################################
grun.varw <- pvcm(inv~value+capital, data=Grunfeld, model="within")
grun.varr <- pvcm(inv~value+capital, data=Grunfeld, model="random")
summary(grun.varr)


###################################################
### code chunk number 21: gmm
###################################################
emp.gmm <- pgmm(log(emp)~lag(log(emp), 1:2)+lag(log(wage), 0:1)+log(capital)+
                lag(log(output), 0:1)|lag(log(emp), 2:99),
                data = EmplUK, effect = "twoways", model = "twosteps")
summary(emp.gmm)


###################################################
### code chunk number 22: gmm2
###################################################
z2 <- pgmm(log(emp) ~ lag(log(emp), 1)+ lag(log(wage), 0:1) +
           lag(log(capital), 0:1) | lag(log(emp), 2:99) +
           lag(log(wage), 2:99) + lag(log(capital), 2:99),        
           data = EmplUK, effect = "twoways", model = "onestep", 
           transformation = "ld")
summary(z2, robust = TRUE)


###################################################
### code chunk number 23: pggls
###################################################
zz <- pggls(log(emp)~log(wage)+log(capital), data=EmplUK, model="pooling")
summary(zz)


###################################################
### code chunk number 24: plm.rnw:1140-1141
###################################################
zz <- pggls(log(emp)~log(wage)+log(capital), data=EmplUK, model="within")


###################################################
### code chunk number 25: plm.rnw:1180-1183
###################################################
znp <- pvcm(inv~value+capital, data=Grunfeld, model="within")
zplm <- plm(inv~value+capital, data=Grunfeld, model="within")
pooltest(zplm,znp)


###################################################
### code chunk number 26: plm.rnw:1189-1190
###################################################
pooltest(inv~value+capital, data=Grunfeld, model="within")


###################################################
### code chunk number 27: plm.rnw:1218-1220
###################################################
g <- plm(inv ~ value + capital, data=Grunfeld, model="pooling")
plmtest(g, effect="twoways", type="ghm")


###################################################
### code chunk number 28: plm.rnw:1225-1226
###################################################
plmtest(inv~value+capital, data=Grunfeld, effect="twoways", type="ghm")


###################################################
### code chunk number 29: plm.rnw:1236-1239
###################################################
gw <- plm(inv ~ value + capital,data=Grunfeld,effect="twoways",model="within")
gp <- plm(inv ~ value + capital,data=Grunfeld,model="pooling")
pFtest(gw,gp)


###################################################
### code chunk number 30: plm.rnw:1242-1243
###################################################
pFtest(inv~value+capital, data=Grunfeld,effect="twoways")


###################################################
### code chunk number 31: plm.rnw:1254-1257
###################################################
gw <- plm(inv~value+capital, data=Grunfeld, model="within")
gr <- plm(inv~value+capital, data=Grunfeld, model="random")
phtest(gw, gr)


###################################################
### code chunk number 32: wtest
###################################################
pwtest(log(gsp)~log(pcap)+log(pc)+log(emp)+unemp, data=Produc)


###################################################
### code chunk number 33: pbsytestJoint
###################################################
pbsytest(log(gsp)~log(pcap)+log(pc)+log(emp)+unemp, data=Produc, test="j")


###################################################
### code chunk number 34: pbsytestAR
###################################################
pbsytest(log(gsp)~log(pcap)+log(pc)+log(emp)+unemp, data=Produc)


###################################################
### code chunk number 35: pbsytestRE
###################################################
pbsytest(log(gsp)~log(pcap)+log(pc)+log(emp)+unemp, data=Produc, test="re")


###################################################
### code chunk number 36: pbltest
###################################################
pbltest(log(gsp)~log(pcap)+log(pc)+log(emp)+unemp, 
        data=Produc, alternative="onesided")


###################################################
### code chunk number 37: generalAR
###################################################
## this can be taken away as soon as attached to plm.rnw
grun.fe <- plm(inv ~ value + capital, data = Grunfeld, model = "within")
pbgtest(grun.fe, order = 2)


###################################################
### code chunk number 38: pwartest
###################################################
pwartest(log(emp) ~ log(wage) + log(capital), data=EmplUK)


###################################################
### code chunk number 39: pwfdtest1
###################################################
pwfdtest(log(emp) ~ log(wage) + log(capital), data=EmplUK)


###################################################
### code chunk number 40: pwfdtest2
###################################################
pwfdtest(log(emp) ~ log(wage) + log(capital), data=EmplUK, h0="fe")


###################################################
### code chunk number 41: pcdtest1
###################################################
pcdtest(inv~value+capital, data=Grunfeld)


###################################################
### code chunk number 42: pcdtest2
###################################################
pcdtest(inv~value+capital, data=Grunfeld, model="within")


###################################################
### code chunk number 43: plm.rnw:1917-1920
###################################################
library("lmtest")
re <- plm(inv~value+capital, data=Grunfeld, model="random")
coeftest(re,vcovHC)


###################################################
### code chunk number 44: plm.rnw:1927-1928
###################################################
coeftest(re, vcovHC(re, method="white2", type="HC3"))


###################################################
### code chunk number 45: waldtest
###################################################
waldtest(re, update(re,.~.-capital),
         vcov=function(x) vcovHC(x, method="white2", type="HC3"))


###################################################
### code chunk number 46: plm.rnw:1945-1947
###################################################
library("car")
linearHypothesis(re, "2*value=capital", vcov.=vcovHC)


###################################################
### code chunk number 47: re
###################################################
library(nlme)
reGLS <- plm(inv~value+capital, data=Grunfeld, model="random")

reML <- lme(inv~value+capital, data=Grunfeld, random=~1|firm)

coef(reGLS)

summary(reML)$coefficients$fixed


###################################################
### code chunk number 48: vcmrand
###################################################
vcm <- pvcm(inv~value+capital, data=Grunfeld, model="random", effect="time")

vcmML <- lme(inv~value+capital, data=Grunfeld, random=~value+capital|year)

coef(vcm)

summary(vcmML)$coefficients$fixed


###################################################
### code chunk number 49: vcmfixed
###################################################
vcmf <- pvcm(inv~value+capital, data=Grunfeld, model="within", effect="time")

vcmfML <- lmList(inv~value+capital|year, data=Grunfeld)


###################################################
### code chunk number 50: gglsre
###################################################
sGrunfeld <- Grunfeld[Grunfeld$firm%in%4:6,]

ggls <- pggls(inv~value+capital, data=sGrunfeld, model="pooling")

gglsML <- gls(inv~value+capital, data=sGrunfeld,
              correlation=corSymm(form=~1|year))

coef(ggls)

summary(gglsML)$coefficients


###################################################
### code chunk number 51: lmAR1
###################################################
Grunfeld$year <- as.numeric(as.character(Grunfeld$year))
lmAR1ML <- gls(inv~value+capital,data=Grunfeld,
               correlation=corAR1(0,form=~year|firm))


###################################################
### code chunk number 52: reAR1
###################################################
reAR1ML <- lme(inv~value+capital, data=Grunfeld,random=~1|firm,
               correlation=corAR1(0,form=~year|firm))


###################################################
### code chunk number 53: fetchcoefs
###################################################
summary(reAR1ML)$coefficients$fixed
coef(reAR1ML$modelStruct$corStruct, unconstrained=FALSE)


###################################################
### code chunk number 54: LRar
###################################################
lmML <- gls(inv~value+capital, data=Grunfeld)
anova(lmML, lmAR1ML)


###################################################
### code chunk number 55: LRarsubRE
###################################################
anova(reML, reAR1ML)


###################################################
### code chunk number 56: LRre
###################################################
anova(lmML, reML)


###################################################
### code chunk number 57: LRresubAR
###################################################
anova(lmAR1ML, reAR1ML)


