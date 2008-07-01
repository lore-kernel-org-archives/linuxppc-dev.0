Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from WA4EHSOBE006.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id E93B6DE37B
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 02:37:35 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca,
	jwboyer@linux.vnet.ibm.com, paulus@samba.org
Subject: [PATCH] powerpc: boot: update for initrd with simpleImage
Date: Tue, 1 Jul 2008 09:37:25 -0700
Message-ID: <20080701163730.2619B1B4005C@mail156-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This change to the makefile corrects the build of a
simpleImage with initrd.

Signed-off-by: John Linn <john.linn@xilinx>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/boot/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1cee2f9..095e04d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -273,7 +273,8 @@ endif
 initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, \
 		$(patsubst dtbImage%, dtbImage.initrd%, \
-		$(patsubst treeImage%, treeImage.initrd%, $(image-y))))
+		$(patsubst simpleImage%, simpleImage.initrd%, \
+		$(patsubst treeImage%, treeImage.initrd%, $(image-y)))))
 initrd-y := $(filter-out $(image-y), $(initrd-y))
 targets	+= $(image-y) $(initrd-y)
 
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
