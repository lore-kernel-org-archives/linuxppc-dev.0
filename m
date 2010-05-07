Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9CF4B7D52
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 17:44:08 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Add reset-type to katmai.dts
Date: Fri,  7 May 2010 09:43:43 +0200
Message-Id: <1273218223-9227-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Katmai needs "reset-type" = "chip reset" (2) to correctly reboot the
board.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/katmai.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 8cf2c0c..7c3be5e 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -44,6 +44,7 @@
 			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
+			reset-type = <2>;	/* Use chip-reset */
 		};
 	};
 
-- 
1.7.1
