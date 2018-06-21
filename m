Return-Path: <brgl@bgdev.pl>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BFMd2DymzF12j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 18:33:14 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id k16-v6so2230213wro.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 01:33:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 2/3] powerpc: dts: use 'atmel' as at24 manufacturer for
 kmcent2
Date: Thu, 21 Jun 2018 10:33:04 +0200
Message-Id: <20180621083305.5322-2-brgl@bgdev.pl>
In-Reply-To: <20180621083305.5322-1-brgl@bgdev.pl>
References: <20180621083305.5322-1-brgl@bgdev.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using compatible strings without the <manufacturer> part for at24 is
now deprecated. Use a correct 'atmel,<model>' value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/powerpc/boot/dts/fsl/kmcent2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts b/arch/powerpc/boot/dts/fsl/kmcent2.dts
index 5922c1ea0e96..3094df05f5ea 100644
--- a/arch/powerpc/boot/dts/fsl/kmcent2.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
@@ -130,7 +130,7 @@
 					#size-cells = <0>;
 
 					eeprom@54 {
-						compatible = "24c02";
+						compatible = "atmel,24c02";
 						reg = <0x54>;
 						pagesize = <2>;
 						read-only;
-- 
2.17.1
