Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5C01BDDFF2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:54 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l47ITncP003463
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:49 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l47ITmql019057
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:29:48 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l47I81Pq022234
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:08:02 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id C82CFAEFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 13:29:47 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l47ITlSm026942
	for linuxppc-dev@ozlabs.org; Mon, 7 May 2007 13:29:47 -0500
Date: Mon, 7 May 2007 13:29:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/13] Document the fsl,
	magic-packet property in gianfar nodes.
Message-ID: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
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
 Documentation/powerpc/booting-without-of.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 0efd8a0..1cd29e1 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1187,6 +1187,10 @@ platforms are moved over to use the flattened-device-tree model.
       MAC addresses passed by the firmware when no information other
       than indices is available to associate an address with a device.
 
+   Optional properties:
+    - fsl,magic-packet : Indicates that this device supports wake
+      on Magic Packet.
+
    Example:
 
 	ethernet@24000 {
-- 
1.5.0.3
