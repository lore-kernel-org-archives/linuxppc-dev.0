Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 96850DDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:39:28 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 01/20] bootwrapper: Update .gitignore
Message-ID: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All cuImage types are ignored, as well as preprocessed .lds files,
and the forthcoming zImage.bin files and embedded planet board images.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/.gitignore |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index eec7af7..2c187ca 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -18,14 +18,14 @@ kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
 uImage
-cuImage
-cuImage.bin.gz
-cuImage.elf
+cuImage.*
 zImage
+zImage.bin.*
 zImage.chrp
 zImage.coff
 zImage.coff.lds
-zImage.lds
+zImage.ep*
+zImage.*lds
 zImage.miboot
 zImage.pmac
 zImage.pseries
-- 
1.5.0.3
