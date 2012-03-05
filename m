Return-Path: <dhdang@apm.com>
Received: from exprod5og115.obsmtp.com (exprod5og115.obsmtp.com [64.18.0.246])
 by ozlabs.org (Postfix) with SMTP id 98F67B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2012 21:58:13 +1100 (EST)
Received: by mail-pw0-f47.google.com with SMTP id rp12so4518200pbb.34
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2012 02:58:10 -0800 (PST)
MIME-Version: 1.0
From: Duc Dang <dhdang@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>,
 Josh Boyer <jwboyer@gmail.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v3 1/2] powerpc/44x: Add new compatible value for EMAC node of
 APM821XX dts file.
Date: Mon,  5 Mar 2012 17:57:42 +0700
Message-Id: <1330945062-15760-1-git-send-email-dhdang@apm.com>
In-Reply-To: <1330920224-3006-1-git-send-email-dhdang@apm.com>
References: <1330920224-3006-1-git-send-email-dhdang@apm.com>
Cc: netdev <netdev@vger.kernel.org>, Duc Dang <dhdang@apm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This compatible value will be used to distinguish some special features of APM821XX EMAC: no half duplex mode support, configuring jumbo frame.

Signed-off-by: Duc Dang <dhdang@apm.com>
---
v3:
 No change since v1/v2 patch sets. Added for completeness.

 arch/powerpc/boot/dts/bluestone.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
index 2a56a0d..74876f7 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -222,7 +222,7 @@
 
 			EMAC0: ethernet@ef600c00 {
 				device_type = "network";
-				compatible = "ibm,emac4sync";
+				compatible = "ibm,emac-apm821xx", "ibm,emac4sync";
 				interrupt-parent = <&EMAC0>;
 				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
-- 
1.7.5.4
