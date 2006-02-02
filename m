Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF37968A3F
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 13:28:40 +1100 (EST)
Message-ID: <43E298BC.4000108@am.sony.com>
Date: Thu, 02 Feb 2006 15:41:48 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Add missing vmlinux.bin target
References: <Pine.LNX.4.44.0511231242510.4183-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0511231242510.4183-100000@gate.crashing.org>
Content-Type: text/plain; charset=US-ASCII
Cc: Kumar Gala <galak@gate.crashing.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With this patch 'make vmlinux.bin' works.  This is needed by
some embedded platforms.  Kumar already added the routines
to actually build the image in arch/powerpc/boot/Makefile.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

--


Index: powerpc-merge.git/arch/powerpc/Makefile
===================================================================
--- powerpc-merge.git.orig/arch/powerpc/Makefile	2006-02-02 15:23:03.000000000 -0800
+++ powerpc-merge.git/arch/powerpc/Makefile	2006-02-02 15:23:53.000000000 -0800
@@ -147,7 +147,7 @@

 CPPFLAGS_vmlinux.lds	:= -Upowerpc

-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm uImage
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm uImage vmlinux.bin

 .PHONY: $(BOOT_TARGETS)
