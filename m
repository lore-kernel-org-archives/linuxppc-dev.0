Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCst44pc2zDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 17:00:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/boot: Update .gitignore
Date: Wed,  1 Feb 2017 17:00:11 +1100
Message-Id: <1485928811-9159-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a few things that have been missed from .gitignore over the years.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index d61c03525777..84774ccba1c2 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -1,4 +1,5 @@
 addnote
+decompress_inflate.c
 empty.c
 hack-coff
 inffast.c
@@ -13,11 +14,13 @@ infutil.h
 kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
+otheros.bld
 uImage
 cuImage.*
 dtbImage.*
 *.dtb
 treeImage.*
+vmlinux.strip
 zImage
 zImage.initrd
 zImage.bin.*
@@ -26,6 +29,7 @@ zImage.coff
 zImage.epapr
 zImage.holly
 zImage.*lds
+zImage.maple
 zImage.miboot
 zImage.pmac
 zImage.pseries
-- 
2.7.4
