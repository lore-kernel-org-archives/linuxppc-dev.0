Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2EA4FDDF37
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 08:45:31 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] Add Timur Tabi to the MAINTAINERS file
Date: Wed, 23 Apr 2008 17:45:26 -0500
Message-Id: <1208990726-9283-1-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add Timur TAbi as the maintainer for the Freescale QE library, the Freescale
QE UART device driver, the Freescale SOC sound drivers, and the Crystal
Semiconductor CS4270 device driver.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.26.

 MAINTAINERS |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90dcbbc..7a8bc0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1104,6 +1104,12 @@ M:	kernel@wantstofly.org
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 
+CIRRUS LOGIC CS4270 SOUND DRIVER
+P:	Timur Tabi
+M:	timur@freescale.com
+L:	alsa-devel@alsa-project.org
+S:	Supported
+
 CIRRUS LOGIC CS4280/CS461x SOUNDDRIVER
 P:	Cirrus Logic Corporation (kernel 2.2 driver)
 M:	Cirrus Logic Corporation, Thomas Woller <twoller@crystal.cirrus.com>
@@ -1626,6 +1632,12 @@ L:	linuxppc-dev@ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 
+FREESCALE QUICC ENGINE LIBRARY
+P:	Timur Tabi
+M:	timur@freescale.com
+L:	linuxppc-dev@ozlabs.org
+S:	Supported
+
 FREESCALE HIGHSPEED USB DEVICE DRIVER
 P:	Li Yang
 M:	leoli@freescale.com
@@ -1640,6 +1652,19 @@ L:	netdev@vger.kernel.org
 L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
+FREESCALE QUICC ENGINE UCC UART DRIVER
+P:	Timur Tabi
+M:	timur@freescale.com
+L:	linuxppc-dev@ozlabs.org
+S:	Supported
+
+FREESCALE SOC SOUND DRIVERS
+P:	Timur Tabi
+M:	timur@freescale.com
+L:	alsa-devel@alsa-project.org
+L:	linuxppc-dev@ozlabs.org
+S:	Supported
+
 FILE LOCKING (flock() and fcntl()/lockf())
 P:	Matthew Wilcox
 M:	matthew@wil.cx
-- 
1.5.3
