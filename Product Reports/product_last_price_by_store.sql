USE POSFAPCENTER;

/* 134 mağazasında 128200 kodlu məhsulun ən son qiymətini göstərir.
PRC_LASTUPDATE əsasında ən yeni qiymət seçilir. */

SELECT *
FROM CRD_PRICES
WHERE PRC_ERPCODE = '134'
AND PRC_ITM_CODE = '128200'
ORDER BY PRC_LASTUPDATE DESC;
