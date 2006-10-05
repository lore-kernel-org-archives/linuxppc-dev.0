Return-Path: <brking@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8FBAA67DD0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 01:52:09 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k95Fq6eY030702
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Oct 2006 11:52:06 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k95Fq6mY146632
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Oct 2006 11:52:06 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k95Fq6CR022978
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Oct 2006 11:52:06 -0400
Message-Id: <200610051552.k95Fq5rw022929@d01av03.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Update pSeries defconfig for SATA
To: paulus@samba.org
From: Brian King <brking@us.ibm.com>
Date: Thu, 05 Oct 2006 10:52:04 -0500
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Since the ipr driver now supports SATA and depends on libata,
enable libata to get built.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6-bjking1/arch/powerpc/configs/pseries_defconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/powerpc/configs/pseries_defconfig~powerpc_sata_config arch/powerpc/configs/pseries_defconfig
--- linux-2.6/arch/powerpc/configs/pseries_defconfig~powerpc_sata_config	2006-10-05 10:11:57.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/configs/pseries_defconfig	2006-10-05 10:12:40.000000000 -0500
@@ -506,7 +506,7 @@ CONFIG_SCSI_SAS_ATTRS=m
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_ATA is not set
+CONFIG_ATA=y
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
_
