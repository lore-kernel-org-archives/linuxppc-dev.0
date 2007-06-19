Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4D01DE0F7
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 17:20:04 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5J7JrQW027893
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 00:19:55 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5J7JqqR017465
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 02:19:53 -0500 (CDT)
Subject: [PATCH 2/2]: Fix the node index confusion for SOC
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1182237571.3269.17.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 19 Jun 2007 15:19:31 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Fix the node index confusion for SOC.
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index bdae4fc..419aa57 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -42,15 +42,15 @@ Table of Contents
     1) Defining child nodes of an SOC
     2) Representing devices without a current OF specification
       a) MDIO IO device
-      c) PHY nodes
       b) Gianfar-compatible ethernet nodes
+      c) PHY nodes
       d) Interrupt controllers
       e) I2C
       f) Freescale SOC USB controllers
       g) Freescale SOC SEC Security Engines
       h) Board Control and Status (BCSR)
       i) Freescale QUICC Engine module (QE)
-      g) Flash chip nodes
+      j) Flash chip nodes
       k) Global Utilities Block
 
   VII - Specifying interrupt information for devices
-- 
1.5.1
