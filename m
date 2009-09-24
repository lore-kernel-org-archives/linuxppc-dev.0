Return-Path: <vivek.mahajan@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CEBE9B7B65
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 19:10:33 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8O9AU5V016414
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 02:10:31 -0700 (MST)
From: Vivek Mahajan <vivek.mahajan@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] powerpc/fsl: 85xx: document cache-sram size as a kernel
	parametric option
Date: Thu, 24 Sep 2009 14:40:23 +0530
Message-Id: <1253783426-11978-1-git-send-email-vivek.mahajan@freescale.com>
Cc: kumar.gala@freescale.com, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds documentation for the size parameter of Freescale's QorIQ
based cache-sram

Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
---
Resending it to linuxppc-dev@ozlabs.org

 Documentation/kernel-parameters.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 0f17d16..3213844 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -412,6 +412,9 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	c101=		[NET] Moxa C101 synchronous serial card
 
+	cache-sram-size=	[PPC] Size of Freescale's QorIQ Cache SRAM
+			See Documentation/powerpc/fsl_85xx_cache_sram.txt.
+
 	cachesize=	[BUGS=X86-32] Override level 2 CPU cache size detection.
 			Sometimes CPU hardware bugs make them report the cache
 			size incorrectly. The kernel will attempt work arounds
-- 
1.5.6.5
