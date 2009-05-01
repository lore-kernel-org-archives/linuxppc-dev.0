Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 20003DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 01:54:09 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so1760083rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 08:54:08 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/boot: add simpleImage.* to clean-files list
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Date: Fri, 01 May 2009 09:54:05 -0600
Message-ID: <20090501155401.25008.57476.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4458abb..bff7f12 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -367,7 +367,7 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
 	zImage.iseries zImage.miboot zImage.pmac zImage.pseries \
-	otheros.bld *.dtb
+	simpleImage.* otheros.bld *.dtb
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
