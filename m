Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7AC70DDE37
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 20:44:55 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l87AioUF001569
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 03:44:51 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l87AilIL017097
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 05:44:50 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/5] Add Freescale DMA engine driver maintainer.
Date: Fri,  7 Sep 2007 18:53:53 +0800
Message-Id: <11891624382764-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1189162437484-git-send-email-wei.zhang@freescale.com>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds Freescale DMA engine driver maintainer.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01f222e..1be4f23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1527,6 +1527,13 @@ L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 W:	http://linux-fbdev.sourceforge.net/
 S:	Maintained
 
+FREESCALE DMA DRIVER
+P;	Zhang Wei
+M:	wei.zhang@freescale.com
+L:	linuxppc-embedded@ozlabs.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 FREESCALE SOC FS_ENET DRIVER
 P:	Pantelis Antoniou
 M:	pantelis.antoniou@gmail.com
-- 
1.5.2
