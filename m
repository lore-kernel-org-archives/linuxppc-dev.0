Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out1.tiscali.nl (smtp-out1.tiscali.nl [195.241.79.176])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B566DDF4F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 10:01:44 +1100 (EST)
Message-ID: <4797C1AD.3040307@tiscali.nl>
Date: Wed, 23 Jan 2008 23:37:33 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: jwboyer@linux.vnet.ibm.com, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH][ppc] logical/bitand typo in powerpc/boot/4xx.c
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

logical/bitand typo

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
index ebf9e21..dcfb459 100644
--- a/arch/powerpc/boot/4xx.c
+++ b/arch/powerpc/boot/4xx.c
@@ -104,7 +104,7 @@ void ibm4xx_denali_fixup_memsize(void)
 	val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
 	cs = 0;
 	while (val) {
-		if (val && 0x1)
+		if (val & 0x1)
 			cs++;
 		val = val >> 1;
 	}
