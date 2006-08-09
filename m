Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 310CC67B62
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 11:07:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k791760J024554
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 Aug 2006 18:07:06 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k791742c010510
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 Aug 2006 20:07:05 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC8349 clocking
Date: Wed, 9 Aug 2006 09:07:04 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635018CA3@zch01exm21.fsl.freescale.net>
In-Reply-To: <44D8BF02.6090103@ovro.caltech.edu>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>,
	"Eric Heim" <sheldoninstruments@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I believe Kumar posted a csb_clk (or lbiu_clk) patch that fixed
> a setting error ... but I can't recall if it was a U-Boot
> patch or a kernel patch. I looked in the CHANGELOG for
> U-Boot and I didn't see a comment related to the clock
> settings (searching based on Kumar, MPC8349, or MPC83xx).

The timebase clock is csbclk, it is correct.
