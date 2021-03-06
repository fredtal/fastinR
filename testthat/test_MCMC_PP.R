context('MCMC pop.prop testing')

test_that('Pop Props with FA give sensible answers',{
  
  FA.predators <- system.file("extdata", "Simdata_FA_preds.csv", package="fastinR")
  FA.preys <- system.file("extdata", "Simdata_FA_preys.csv", package="fastinR")
  Conv.Coeffs.mean <- system.file("extdata", "Simdata_FA_cc_means.csv", package="fastinR")
  Conv.Coeffs.var <- system.file("extdata", "Simdata_FA_cc_var.csv", package="fastinR")
  fat.conts <- system.file("extdata", "Simdata_fat_cont.csv", package="fastinR")
  SI.predators <- system.file("extdata", "Simdata_SI_preds.csv", package="fastinR")
  SI.preys <- system.file("extdata", "Simdata_SI_preys.csv", package="fastinR")
  Frac.Coeffs.mean <- system.file("extdata", "Simdata_SI_fc_means.csv", package="fastinR")
  Frac.Coeffs.var <- system.file("extdata", "Simdata_SI_fc_var.csv", package="fastinR")
  
  dats <- add_FA(FA.predators=FA.predators,FA.preys=FA.preys,fat.conts=fat.conts,Conv.Coeffs.mean=Conv.Coeffs.mean,Conv.Coeffs.var=Conv.Coeffs.var)
  datas <- add_SI(SI.predators=SI.predators,SI.preys=SI.preys,Frac.Coeffs.mean=Frac.Coeffs.mean,Frac.Coeffs.var=Frac.Coeffs.var,datas=dats)
  
  dats <- select_vars(datas,ix=c(2,7,3,6,8))
  
  dat <- run_MCMC(dats,nIter=10000,nBurnin=2000,nChains=3,nThin=10,Data.Type='Fatty.Acid.Profiles',Analysis.Type='Population.proportions',even=0.1,plott=F)
  
  expect_is(dat,"pop_props")
  
  prop <- system.file("extdata", "Simdata_props.csv", package="fastinR")
  props <- read.csv(prop,header=F,row.names=1)
  expect_false(sum(abs(colMeans(props)-colMeans(do.call('rbind',dat[1:3]))))>0.2)
  
})

test_that('Pop Props with SI give sensible answers',{
  
  
  dat <- run_MCMC(datas,nIter=10000,nBurnin=2000,nChains=3,nThin=10,Data.Type='Stable.Isotopes',Analysis.Type='Population.proportions',even=0.1,plott=F)
  
  expect_is(dat,"pop_props")
  
  prop <- system.file("extdata", "Simdata_props.csv", package="fastinR")
  props <- read.csv(prop,header=F,row.names=1)
  expect_true(sum(abs(colMeans(props)-colMeans(do.call('rbind',dat[1:3]))))>0.2)
  
})

test_that('Pop Props with combined give sensible answers',{
  
  data('Sim',envir = environment())
  
  dats <- select_vars(datas,ix=c(2,7,3,6,8))
  
  dat <- run_MCMC(dats,nIter=10000,nBurnin=2000,nChains=3,nThin=10,Data.Type='Combined.Analysis',Analysis.Type='Population.proportions',even=0.1,plott=F)
  
  expect_is(dat,"pop_props")
  
  prop <- system.file("extdata", "Simdata_props.csv", package="fastinR")
  props <- read.csv(prop,header=F,row.names=1)
  expect_false(sum(abs(colMeans(props)-colMeans(do.call('rbind',dat[1:3]))))>0.2)
  
})


test_that('Spawning works',{
  
  
  dat <- run_MCMC(datas,nIter=10000,nBurnin=2000,nChains=3,nThin=10,Data.Type='Stable.Isotopes',Analysis.Type='Population.proportions',even=0.1,plott=F,spawn=T)
  
  expect_is(dat,"pop_props")
  
  prop <- system.file("extdata", "Simdata_props.csv", package="fastinR")
  props <- read.csv(prop,header=F,row.names=1)
  expect_true(sum(abs(colMeans(props)-colMeans(do.call('rbind',dat[1:3]))))>0.2)
  
})