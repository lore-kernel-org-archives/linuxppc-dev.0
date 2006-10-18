Return-Path: <b04825@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 9E3B167B89
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 08:27:38 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9INmDdI028014
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 17:48:13 -0600 (MDT)
From: timur@freescale.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix spelling errors in ucc_fast.c and ucc_slow.c
Date: Wed, 18 Oct 2006 17:27:32 -0500
Message-Id: <1161210452371-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

In ucc_fast.c and ucc_slow.c, "illegal" is twice spelled "illagal".

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |    2 +-
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index c2be734..75fa310 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -163,7 +163,7 @@ int ucc_fast_init(struct ucc_fast_info *
 
 	/* check if the UCC port number is in range. */
 	if ((uf_info->ucc_num < 0) || (uf_info->ucc_num > UCC_MAX_NUM - 1)) {
-		uccf_err("ucc_fast_init: Illagal UCC number!");
+		uccf_err("ucc_fast_init: Illegal UCC number!");
 		return -EINVAL;
 	}
 
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 1fb88ef..a49da6b 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -152,7 +152,7 @@ int ucc_slow_init(struct ucc_slow_info *
 
 	/* check if the UCC port number is in range. */
 	if ((us_info->ucc_num < 0) || (us_info->ucc_num > UCC_MAX_NUM - 1)) {
-		uccs_err("ucc_slow_init: Illagal UCC number!");
+		uccs_err("ucc_slow_init: Illegal UCC number!");
 		return -EINVAL;
 	}
 
-- 
1.4.2.1
