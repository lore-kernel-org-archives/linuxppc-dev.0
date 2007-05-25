Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E31FDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 15:52:22 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l4P5qGWp013047 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 22:52:17 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4P5qFUM025403
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 00:52:16 -0500 (CDT)
Message-ID: <465679FA.8010702@freescale.com>
Date: Fri, 25 May 2007 13:54:02 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: jeff@garzik.org
Subject: [PATCH] NET: add MAINTAINERS entry for ucc_geth driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c3277c..3faed72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1463,6 +1463,13 @@ L:	linux-usb-devel@lists.sourceforge.net
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
 
+FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
+P:	Li Yang
+M:	leoli@freescale.com
+L:	netdev@vger.kernel.org
+L:	linuxppc-embedded@ozlabs.org
+S:	Maintained
+
 FILE LOCKING (flock() and fcntl()/lockf())
 P:	Matthew Wilcox
 M:	matthew@wil.cx
