USE POSFAPCENTERPLUS;

/* Bank ödənişi olan satışların hesabatını çıxarın. 
Hər satış üçün tarix, çek nömrəsi, kassir, məhsul, məbləğ, bank statusu və əməliyyat növü göstərilsin. */

SELECT 
	BNK_FICHENO,
	BNK_TERMINALCODE,
	BNK_TRNSTATUS,
	BNK_APPROVALCODE,
	INV_DATETIME,
	INV_NETTOTAL,
	USR_NAME,
	STL_ITMCODE,
	ITM_NAME,
	STL_AMOUNT,
	BNK_TYPE, -- (sale = satis olub) (void = legv oldu) (settlement = gun sonu olan stis)
	BNK_STATE, -- idle yeni emeliyat icra olunur  

	CASE 
    WHEN BNK_TRNSTATUS = 'approved' THEN 'Ugurlu'
	WHEN BNK_TRNSTATUS = 'not approved' THEN 'Natamam'
	ELSE 'Yoxlayir'
    END AS RESULT,
	
	CASE
	WHEN BNK_TYPE = 'sale' THEN 'Satis oldu'
	WHEN BNK_TYPE = 'void' THEN 'Legv olub'
	WHEN BNK_TYPE = 'settlement' THEN 'gun sonu'
	ELSE 'digerleri'
	END AS STATUS

FROM OPR_INVOICE
LEFT JOIN OPR_STLINE
ON STL_FICHENO = INV_FICHENO
LEFT JOIN OPR_ACCOUNTS
ON ACO_INVFICHENO = INV_FICHENO
LEFT JOIN CRD_BANKTERMINAL
ON POS_TERMINAL = ACO_TERMINAL
LEFT JOIN OPR_BANK
ON BNK_FICHENO = INV_FICHENO
LEFT JOIN CRD_ITEMS
ON ITM_CODE = STL_ITMCODE
LEFT JOIN SYS_USERS_
ON USR_CSCID = INV_CSC_ID
WHERE BNK_FICHENO IS NOT NULL;
