Return-Path: <roel.kluin@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 7C101DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 06:48:31 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so476883eyi.15
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 13:48:29 -0700 (PDT)
Message-ID: <48B9B218.6060506@gmail.com>
Date: Sat, 30 Aug 2008 22:48:24 +0200
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: david@gibson.dropbear.id.au, benh@kernel.crashing.org
Subject: [PATCH] ibm_newemac: MAL[12]_IER_EVENTS definition: 2x *_OTE -> *_DE
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MAL[12]_IER_EVENTS definitions have MAL_IER_OTE twice
but lack MAL_IER_DE

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/net/ibm_newemac/mal.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ibm_newemac/mal.h b/drivers/net/ibm_newemac/mal.h
index eaa7262..717dc38 100644
--- a/drivers/net/ibm_newemac/mal.h
+++ b/drivers/net/ibm_newemac/mal.h
@@ -102,7 +102,7 @@
 /* MAL V1 IER bits */
 #define   MAL1_IER_NWE		0x00000008
 #define   MAL1_IER_SOC_EVENTS	MAL1_IER_NWE
-#define   MAL1_IER_EVENTS	(MAL1_IER_SOC_EVENTS | MAL_IER_OTE | \
+#define   MAL1_IER_EVENTS	(MAL1_IER_SOC_EVENTS | MAL_IER_DE | \
 				 MAL_IER_OTE | MAL_IER_OE | MAL_IER_PE)
 
 /* MAL V2 IER bits */
@@ -110,7 +110,7 @@
 #define   MAL2_IER_PRE		0x00000040
 #define   MAL2_IER_PWE		0x00000020
 #define   MAL2_IER_SOC_EVENTS	(MAL2_IER_PT | MAL2_IER_PRE | MAL2_IER_PWE)
-#define   MAL2_IER_EVENTS	(MAL2_IER_SOC_EVENTS | MAL_IER_OTE | \
+#define   MAL2_IER_EVENTS	(MAL2_IER_SOC_EVENTS | MAL_IER_DE | \
 				 MAL_IER_OTE | MAL_IER_OE | MAL_IER_PE)
 
 
