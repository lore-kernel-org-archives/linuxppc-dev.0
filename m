Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62F5BDDF63
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:52 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l47ITlQ6024212
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:48 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l47ITlLF017446
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:29:47 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l47I80vc022230
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:08:00 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 6910AAEFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 13:29:46 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l47ITksO026938
	for linuxppc-dev@ozlabs.org; Mon, 7 May 2007 13:29:46 -0500
Date: Mon, 7 May 2007 13:29:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/13] Document the devtree binding for general purpose timers.
Message-ID: <20070507182946.GC26920@ld0162-tx32.am.freescale.net>
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

The GTM module on the 83xx will be used as a wakeup source for
suspend-to-ram.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 966c26b..0efd8a0 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1750,6 +1750,13 @@ platforms are moved over to use the flattened-device-tree model.
 
    More devices will be defined as this spec matures.
 
+   m) General Purpose Timers
+
+   - compatible : For the GTM module on mpc83xx chips,
+     use "fsl,mpc83xx-gtm".
+   - reg : For fsl,mpc83xx-gtm, resource 0 is the GTM block.
+   - interrupts : This is the timer's interrupt.
+
 VII - Specifying interrupt information for devices
 ===================================================
 
-- 
1.5.0.3
