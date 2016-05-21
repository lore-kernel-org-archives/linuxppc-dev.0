Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk6q1mfBzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:06:27 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id d132so1683173lfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:06:27 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, christophe.leroy@c-s.fr, oss@buserror.net,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0228/1529] Fix typo
Date: Sat, 21 May 2016 14:06:18 +0200
Message-Id: <20160521120618.11846-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/lib/checksum_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 8e6e510..f3b5b7d 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -74,7 +74,7 @@ _GLOBAL(__csum_partial)
 	ld	r11,24(r3)
 
 	/*
-	 * On POWER6 and POWER7 back to back addes take 2 cycles because of
+	 * On POWER6 and POWER7 back to back adds take 2 cycles because of
 	 * the XER dependency. This means the fastest this loop can go is
 	 * 16 cycles per iteration. The scheduling of the loop below has
 	 * been shown to hit this on both POWER6 and POWER7.
@@ -275,7 +275,7 @@ source;	ld	r10,16(r3)
 source;	ld	r11,24(r3)
 
 	/*
-	 * On POWER6 and POWER7 back to back addes take 2 cycles because of
+	 * On POWER6 and POWER7 back to back adds take 2 cycles because of
 	 * the XER dependency. This means the fastest this loop can go is
 	 * 16 cycles per iteration. The scheduling of the loop below has
 	 * been shown to hit this on both POWER6 and POWER7.
-- 
2.8.2.534.g1f66975
