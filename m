Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 05F5467EFE
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 11:08:33 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	kAB0MO1V018353
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 17:22:24 -0700 (MST)
Received: from ld0028-tx32 (ld0028-tx32.am.freescale.net [10.82.19.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with SMTP id kAB08VtF008018
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 18:08:31 -0600 (CST)
Date: Fri, 10 Nov 2006 18:08:30 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] make git ignore new wrapper generated files
Message-Id: <20061110180830.419c28bd.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new 'wrapper' code generates files that git should ignore;
add them to .gitignore.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/.gitignore |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 45c9ad2..590e72f 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -1,20 +1,27 @@
 addnote
+empty.c
+hack-coff
 infblock.c
 infblock.h
 infcodes.c
 infcodes.h
 inffast.c
 inffast.h
+inffixed.h
 inflate.c
+inflate.h
 inftrees.c
 inftrees.h
 infutil.c
 infutil.h
 kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
+mktree
 uImage
 zImage
 zImage.vmode
+zImage.coff.lds
+zImage.lds
 zconf.h
 zlib.h
 zutil.h
-- 
1.4.2.3
