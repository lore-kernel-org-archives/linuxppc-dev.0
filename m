Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 32C23DDE10
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 19:30:23 +1000 (EST)
Received: from ubuntu (achn-4db49b11.pool.einsundeins.de [77.180.155.17])
	by post.webmailer.de (mrclete mo33) (RZmta 7.1)
	with ESMTP id C06f5aj526s5zc for <linuxppc-dev@ozlabs.org>;
	Sat, 2 Jun 2007 11:30:20 +0200 (MEST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: Fix compile breakage for IBM/AMCC 4xx arch/ppc platforms
Date: Sat, 2 Jun 2007 11:30:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706021130.20215.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The IBM/AMCC 405 platforms don't compile anymore in the current
kernel version. This small patch fixes the small compile breakage.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 90ea0ac115801170097f0628a2851fc78006de3c
tree d59c13cdfcd3aa4a241a1c5b598d76fa3f18b540
parent f285e3d329ce68cc355fadf4ab2c8f34d7f264cb
author Stefan Roese <sr@denx.de> Sat, 02 Jun 2007 11:26:15 +0200
committer Stefan Roese <sr@denx.de> Sat, 02 Jun 2007 11:26:15 +0200

 arch/ppc/syslib/ibm_ocp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/syslib/ibm_ocp.c b/arch/ppc/syslib/ibm_ocp.c
index 3f6e55c..2ee1766 100644
--- a/arch/ppc/syslib/ibm_ocp.c
+++ b/arch/ppc/syslib/ibm_ocp.c
@@ -1,4 +1,5 @@
 #include <linux/module.h>
+#include <asm/ibm4xx.h>
 #include <asm/ocp.h>
 
 struct ocp_sys_info_data ocp_sys_info = {
