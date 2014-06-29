Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com
 [IPv6:2a00:1450:400c:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 901861A0012
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 20:21:50 +1000 (EST)
Received: by mail-we0-f169.google.com with SMTP id t60so6962229wes.14
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 03:21:44 -0700 (PDT)
Sender: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH -trivial 1/4] powerpc/simpleboot: Spelling s/trucate/truncate/
Date: Sun, 29 Jun 2014 12:21:36 +0200
Message-Id: <1404037299-31570-1-git-send-email-geert@linux-m68k.org>
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/boot/simpleboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/simpleboot.c b/arch/powerpc/boot/simpleboot.c
index 21cd48074ec8..9f8c678f0d9a 100644
--- a/arch/powerpc/boot/simpleboot.c
+++ b/arch/powerpc/boot/simpleboot.c
@@ -61,7 +61,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 		if (*reg++ != 0)
 			fatal("Memory range is not based at address 0\n");
 
-	/* get the memsize and trucate it to under 4G on 32 bit machines */
+	/* get the memsize and truncate it to under 4G on 32 bit machines */
 	memsize64 = 0;
 	for (i = 0; i < *ns; i++)
 		memsize64 = (memsize64 << 32) | *reg++;
-- 
1.9.1
