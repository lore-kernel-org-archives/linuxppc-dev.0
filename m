Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id E479CDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:06:39 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1JL6Zbv024531
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 14:06:36 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1JL6Zrl014140
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 15:06:35 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: macros and dtc
Date: Mon, 19 Feb 2007 14:06:34 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1C39C@az33exm25.fsl.freescale.net>
In-Reply-To: <0B394386-47DB-47C1-A3F3-BCE80F30B528@embeddedalley.com>
References: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
	<F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1C2F1@az33exm25.fsl.freescale.net>
	<0B394386-47DB-47C1-A3F3-BCE80F30B528@embeddedalley.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Dan Malek" <dan@embeddedalley.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddedalley.com]=20
> Sent: Monday, February 19, 2007 2:17 PM
> To: Yoder Stuart-B08248
> Cc: Kumar Gala; Linux PPC Dev ML; Jon Loeliger; David Gibson
> Subject: Re: macros and dtc
>=20
>=20
> On Feb 19, 2007, at 1:57 PM, Yoder Stuart-B08248 wrote:
>=20
> > bus-frequency =3D <33MHZ> is much better than
> > bus-frequency =3D <13ab6680>
>=20
> Except, 33MHZ isn't a valid macro name, and if
> these constants would have been _decimal_
> in the first place, 33000000, or 33333333 would
> be understandable :-)  I've screwed up by thinking
> (or not, I guess) these are decimal numbers.....
> I agree with you, though.  Of course, these values
> should be zero in the dts and filled in by
> the boot loader/wrapper.

Ok. (guess I picked a bad example:)  The main point,
though, is that symbolic names are generally more
helpful and clear than bare constants. =20

Stuart
