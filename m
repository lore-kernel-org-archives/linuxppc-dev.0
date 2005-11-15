Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0048E68753
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2005 04:05:32 +1100 (EST)
Date: Tue, 15 Nov 2005 09:05:14 -0800
To: paulus@samba.org
Message-ID: <20051115170514.GA7241@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add new powerbooks to feature table
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The previous PowerBook patch didn't contain the feature table updates
for ARCH=powerpc. Here they are.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: linux-2.6/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/feature.c	2005-11-15 00:05:28.000000000 -0800
+++ linux-2.6/arch/powerpc/platforms/powermac/feature.c	2005-11-15 00:05:59.000000000 -0800
@@ -2362,6 +2362,14 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook5,8",			"PowerBook G4 15\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
+	{	"PowerBook5,9",			"PowerBook G4 17\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
