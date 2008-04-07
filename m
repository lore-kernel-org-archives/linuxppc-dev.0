Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B93ADE098
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 04:56:14 +1000 (EST)
Date: Mon, 7 Apr 2008 11:55:48 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080407185548.GJ7438@farnsworth.org>
References: <20080407183228.GA7438@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080407183228.GA7438@farnsworth.org>
Subject: [PATCH 9/9 v2] powerpc: prpmc2800 needs a dtbImage
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

The prpmc2800 platform requires a zImage formatted file with an
embedded dtb file.  Rename the requested boot image file to
dtbImage.prpmc2800.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Acked-by: Mark A. Greer <mgreer@mvista.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

---
 arch/powerpc/boot/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -192,7 +192,7 @@ image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
 image-$(CONFIG_PPC_HOLLY)		+= zImage.holly
-image-$(CONFIG_PPC_PRPMC2800)		+= zImage.prpmc2800
+image-$(CONFIG_PPC_PRPMC2800)		+= dtbImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
