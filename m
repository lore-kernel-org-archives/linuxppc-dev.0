Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id B7A08DDF15
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 04:12:25 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 0A4FD14355
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:13:33 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00621-04 for <linuxppc-dev@ozlabs.org>;
	Fri,  9 Nov 2007 18:13:32 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 0273E1431C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:13:31 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v4 06/13] [POWERPC] Use EXPORT_SYMBOL_GPL for 52xx common
	routines symbol export
To: linuxppc-dev@ozlabs.org
Date: Fri, 09 Nov 2007 18:12:14 +0100
Message-ID: <20071109171214.16289.81121.stgit@hekate.izotz.org>
In-Reply-To: <20071109171137.16289.39575.stgit@hekate.izotz.org>
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL in mpc52xx_common.c

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 7224bfe..c9e1ab9 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -55,16 +55,14 @@ mpc52xx_find_and_map(const char *compatible)
 	return mpc52xx_map_node(
 		of_find_compatible_node(NULL, NULL, compatible));
 }
-
-EXPORT_SYMBOL(mpc52xx_find_and_map);
+EXPORT_SYMBOL_GPL(mpc52xx_find_and_map);
 
 void __iomem *
 mpc52xx_find_and_map_path(const char *path)
 {
 	return mpc52xx_map_node(of_find_node_by_path(path));
 }
-
-EXPORT_SYMBOL(mpc52xx_find_and_map_path);
+EXPORT_SYMBOL_GPL(mpc52xx_find_and_map_path);
 
 /**
  * 	mpc52xx_find_ipb_freq - Find the IPB bus frequency for a device
@@ -93,7 +91,7 @@ mpc52xx_find_ipb_freq(struct device_node *node)
 
 	return p_ipb_freq ? *p_ipb_freq : 0;
 }
-EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
+EXPORT_SYMBOL_GPL(mpc52xx_find_ipb_freq);
 
 
 /*
