Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 35E6FDDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 04:02:17 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1FH2E5l013051
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:02:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1FH2DUj015947
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:02:13 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 15/16] Add device tree for Ebony 
Date: Thu, 15 Feb 2007 10:02:12 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BAF0@az33exm25.fsl.freescale.net>
In-Reply-To: <865018a527ef1056f628250167301e64@kernel.crashing.org>
References: <20070213061026.5837FDDDE9@ozlabs.org><e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org><20070214002210.GE11491@localhost.localdomain><45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org><20070214231734.GC16279@localhost.localdomain><90e2bb990b7e1f46c6eaccd1d9255d77@kernel.crashing.org><E1HHhCD-0004Hf-QT@jdl.com>
	<865018a527ef1056f628250167301e64@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Jon Loeliger" <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
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
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Segher Boessenkool
> Sent: Thursday, February 15, 2007 8:57 AM
> To: Jon Loeliger
> Cc: linuxppc-dev@ozlabs.org; David Gibson
> Subject: Re: [PATCH 15/16] Add device tree for Ebony=20
>=20
> >> The first option.  Anywhere a number can be used, "d# xxx"
> >> would mean decimal.
> >>
> >> When you would say <d# 1234  5678>, 1234 is decimal and
> >> 5678 is hexadecimal.
> >
> > Where do the tokens end?  Is "d#1234" valid and equal to "d# 1234"?
> > Or is "d#" an independent token?
>=20
> In OF, there has to be whitespace inbetween.
>=20
> > And are there other bases to
> > this model?  Like, maybe, "b#", "o#" and "h#" as well?
>=20
> o# d# h# are standard defined; b# exists on many implementations.

1275 specifies whitespace inbetween, but isn't this due to=20
the way they are describing things for the forth / stack-based
operations?

I would prefer in the DTS files to have no whitespace in=20
between--  <d#1234 #h5678> seems much more readable
than <d# 1234 #h 5678>.

Or even better-- just use standard C notation
    <1234 0x5678>

That is very readable.  Why bring unnecessary complexity into
this?

Stuart
