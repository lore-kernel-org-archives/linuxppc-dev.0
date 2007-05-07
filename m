Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 839A8DDF26
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l47ITk4L003436
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:46 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l47ITjcv019051
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:29:46 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l47I7xba022226
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:07:59 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id E441FAEFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 13:29:44 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l47ITi8w026934
	for linuxppc-dev@ozlabs.org; Mon, 7 May 2007 13:29:44 -0500
Date: Mon, 7 May 2007 13:29:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/13] Document the sleep property.
Message-ID: <20070507182944.GB26920@ld0162-tx32.am.freescale.net>
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
 Documentation/powerpc/booting-without-of.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index fc54511..966c26b 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1738,6 +1738,16 @@ platforms are moved over to use the flattened-device-tree model.
 
    - interrupts : On fsl,mpc83xx-pmc, this is the PMC interrupt.
 
+   l) Device Power Management
+
+   To associate a device with the corresponding bits in a power or
+   clock disable register, a device can contain a "sleep" property.
+
+   The first cell of a sleep node is a phandle to the sleep controller.
+   The remaining cells are interpreted by said controller.  In the case
+   of an fsl,mpc83xx-pmc sleep controller, the second cell represents the
+   bits to clear in SCCR to stop the device's clock.
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
-- 
1.5.0.3
