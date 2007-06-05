Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6CE1BDDE38
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 16:05:40 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5565YwO012304
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 23:05:34 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5565Uis010694
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Jun 2007 01:05:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Tue, 5 Jun 2007 14:05:29 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E82CC4F@zch01exm23.fsl.freescale.net>
In-Reply-To: <12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
References: <1180720112.14219.62.camel@ld0161-tx32><dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org><1180734314.5674.49.camel@rhino><4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org><20070602085359.GA10333@iram.es><3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org><20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Gabriel Paubert" <paubert@iram.es>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> >> Yes, I think we all agree -- it should be interrupt-controller@20,
> >> with 20, a0, 4d0 in the "reg" property.
> >
> > In the current tree it is called "i8259" in mpc8641_hpcn.dts.
>=20
> "interrupt-controller" is the preferred name for all
> interrupt controller nodes.  The "compatible" property
> can easily distinguish between different types.  Not
> that it matters all that much -- just remember that
> the "name" is used for device matching before "compatible"
> is (_should_ be, Linux ignores this part of the standard
> right now in most cases), so don't put junk in there!
>=20
> > The other
> > ones which have a 8259 are not usable (mpc8555 for example). I don't
> > even understand their reg property (19000 0 0 0 1),
>=20
> Very weird indeed.  What bustype is this?  (I looked it up,
> it's PCI, and I can't make heads or tails of it either --
> it says it sits on bus #1, although its parent isn't bus #1;
> and the final "1" should be "0".  Many more weird things
> in that node, too).
This 8259 controller in a VIA82C686 chip is behind a tsi310 bridge  on
pci1.
Bus #1 should correct.
It is not enabled in 8555CDS board.
Roy
