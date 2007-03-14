Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F6A0DDE39
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 20:20:04 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH 13/17] ANSIfy powerpc floppy.h
Message-Id: <E1HRPeK-0003Yo-26@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 14 Mar 2007 09:20:00 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-powerpc/floppy.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/floppy.h b/include/asm-powerpc/floppy.h
index a0f14ee..afa700d 100644
--- a/include/asm-powerpc/floppy.h
+++ b/include/asm-powerpc/floppy.h
@@ -178,7 +178,7 @@ static struct fd_dma_ops virt_dma_ops =
 	._dma_setup = vdma_dma_setup
 };
 
-static int fd_request_dma()
+static int fd_request_dma(void)
 {
 	if (can_use_virtual_dma & 1) {
 		fd_ops = &virt_dma_ops;
-- 
1.5.0-rc2.GIT
