Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FDD5DDF26
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:48 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l47ITiJ3024175
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:44 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l47ITil7017423
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:29:44 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l47I7vW7022220
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:07:57 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 45F5EAEFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 13:29:43 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l47IThbQ026930
	for linuxppc-dev@ozlabs.org; Mon, 7 May 2007 13:29:43 -0500
Date: Mon, 7 May 2007 13:29:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/13] Document devtree binding for power management
	controllers.
Message-ID: <20070507182943.GA26920@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index aaea829..fc54511 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1725,6 +1725,19 @@ platforms are moved over to use the flattened-device-tree model.
  		partition-names = "fs\0firmware";
  	};
 
+   k) Power Management Controllers
+
+   Required Properties:
+
+   - compatible : mpc83xx chips should use "fsl,mpc83xx-pmc".  831x chips
+     with additional PMC functionality also list "fsl,mpc831x-pmc".
+   - reg : For fsl,mpc83xx-pmc devices, resource 0 is the PMC reg block,
+     and resource 1 is the Clock Configuration reg block.
+
+   Optional Properties:
+
+   - interrupts : On fsl,mpc83xx-pmc, this is the PMC interrupt.
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
-- 
1.5.0.3
