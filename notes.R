AUC <- tapply(AUC.0$area_under_curve, list(r = AUC.0$ccl_name, c = AUC.0$cpd_name), FUN = max)
