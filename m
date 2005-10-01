Return-Path: <shenkel@gmail.com>
Received: from dd3624.kasserver.com (dd3624.kasserver.com [81.209.188.85])
	by ozlabs.org (Postfix) with ESMTP id 4140C6838E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Oct 2005 18:15:58 +1000 (EST)
From: Sven Henkel <shenkel@gmail.com>
To: benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Date: Sat, 1 Oct 2005 09:57:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510010957.46658.shenkel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Add new iBook 12" to PowerMac models table
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this patch adds the new iBook G4 (manufactured after July 2005) to the PowerMac 
models table. The model name (PowerBook6,7) is taken from a 12" iBook, I 
don't know if it also matches the 14" version. The patch applies to a vanilla 
2.6.13.2 kernel.

Ciao,
Sven

Signed-off-by: Sven Henkel <shenkel@gmail.com>

--- linux-2.6.13.2-orig/arch/ppc/platforms/pmac_feature.c	2005-09-30 19:26:55.000000000 +0200
+++ linux-2.6.13.2-dev/arch/ppc/platforms/pmac_feature.c	2005-09-30 20:07:52.000000000 +0200
@@ -2337,6 +2337,10 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook6,7",			"iBook G4",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,8",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
