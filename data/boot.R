

bootSE<-function(mod,nBoot=100)
{
  #check if lm glm or lme4
  
  if(!class(mod)[1]%in%c("lmerMod","glmerMod","lm","glm")){
    stop("null model not valid lm, glm, or lme4 object")
  }
  
  
  #change formula to simulations
  new.formula=update(formula(mod),boot.y~.)

  if(class(mod)[1]%in%c("lm","glm")){
    nfixed=length(coef(mod))
  }else{nfixed=length(fixef(mod))}
  mod.copy=mod
  
  bStat=matrix(NA,nfixed,(nBoot))
  for(k in 1:(nBoot)) {
    y <- unlist(simulate(mod)) 
    if(class(mod)[1]%in%c("lm","glm")){
      boot.dat <- data.frame(boot.y=y, mod$model)
      boot.mod=update(mod,new.formula,data=boot.dat)
      bStat[,k] = coef(boot.mod)
      nms=names(coef(mod))
    }else {
      boot.mod=refit(mod,y)
      bStat[,k] = fixef(boot.mod)
      nms=names(fixef(mod))
    }
  }
  
  vcv=cov(t(bStat))
  se=apply(bStat,1,sd)
  out=data.frame(paramater=nms,Std=se,vcv=vcv)
  colnames(out)[3]="Covariance"
  colnames(out)[-c(1,2,3)]=""
  print(out)
  invisible(list(Covariance=se))
}

  
 
  
  
bootLRT<-function(fit.null,fit.alt,nBoot=100)
{
  
  #refit by max lik if lmer
  if(class(fit.null)[1]%in%c("lmerMod")){
    fit.null=update(fit.null,REML=F)
  }
  
  if(class(fit.alt)[1]%in%c("lmerMod")){
    fit.alt=update(fit.alt,REML=F)
  }
  
  #observed test stat
  test.stat <- as.numeric(2*(logLik(fit.alt) - logLik(fit.null)))
  boot.stat <- numeric(nBoot-1)
  
  if(test.stat<=0){
    stop("smaller model must be listed first")
  }
  
  
  #check if nested
  
  if(!all(all.vars(formula(fit.null))%in%all.vars(formula(fit.alt)))){
    stop("null model not nested in alternate model")
  }
  
  #check if lm glm or lme4
  
  if(!class(fit.null)[1]%in%c("lmerMod","glmerMod","lm","glm")){
    stop("null model not valid lm, glm, or lme4 object")
  }
  
  if(!class(fit.alt)[1]%in%c("lmerMod","glmerMod","lm","glm")){
    error("alternate model not valid lm, glm, or lme4 obsect")
  }
  
  #check if same family
  if(family(fit.null)[1]$family!=family(fit.alt)[1]$family){
    stop("models do not have the same family argument")
  }
  
  
  #change formula to simulations
  null.formula=update(formula(fit.null),boot.y~.)
  alt.formula=update(formula(fit.alt),boot.y~.)
  
  for(k in 1:(nBoot-1)) {
    y <- unlist(simulate(fit.null)) 
    
    if(class(fit.null)[1]%in%c("lm","glm")){
      boot.dat <- data.frame(boot.y=y, fit.null$model)
      boot.fit.null=update(fit.null,null.formula,data=boot.dat)
    }else {boot.fit.null=refit(fit.null,y)}
    
    if(class(fit.alt)[1]%in%c("lm","glm")){
      boot.dat <- data.frame(boot.y=y, fit.alt$model)
      boot.fit.alt=update(fit.alt,alt.formula,data=boot.dat)
    }else {boot.fit.alt=refit(fit.alt,y)}
      
    boot.stat[k] <- as.numeric(2*(logLik(boot.fit.alt) - logLik(boot.fit.null)))
  }
  pval=mean(c(boot.stat,test.stat) >= test.stat)
#   pval=round(mean(boot.stat > test.stat),3)
  
  print("Model 1")
  print(formula(fit.null))
  print("Model 2")
  print(formula(fit.alt))
  print(paste(nBoot," simulations"))
  print(paste("Bootstrap p-value = ", pval ))
  
  
  invisible(list(boot.LR=boot.stat,obs.LR=test.stat,pval=pval))
  
  
}




