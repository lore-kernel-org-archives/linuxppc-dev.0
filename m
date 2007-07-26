Return-Path: <Martin.Leisner@xerox.com>
Received: from wbmler2.mail.xerox.com (wbmler2.mail.xerox.com [13.13.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler2.mail.xerox.com",
	Issuer "wbmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1E6B2DDED7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jul 2007 01:17:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: support for MPC8220?
Date: Thu, 26 Jul 2007 11:17:32 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C066B5B5E@usa0300ms03.na.xerox.net>
In-Reply-To: <20070724211104.GL1678@pengutronix.de>
References: <556445368AFA1C438794ABDA8901891C066B5B56@usa0300ms03.na.xerox.net>
	<20070724211104.GL1678@pengutronix.de>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
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

=20
actually, it's there -- you have to find it (I saw it once, I can't
find it again).  (other search engines seem to do a better job).

I think MPC8220 runs well without MMU -- the montavista PRO 3.1 the
freescale
site discusses 2.4.20...

We ran an 8220 at one time on 2.4.20 -- I recall there was some
flakiness, and we used
a montavista system, so it must have been 3.1...


marty

> -----Original Message-----
> From: Robert Schwebel [mailto:rsc@pengutronix.de] On Behalf=20
> Of Robert Schwebel
> Sent: Tuesday, July 24, 2007 5:11 PM
> To: Leisner, Martin
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: support for MPC8220?
>=20
> On Mon, Jul 23, 2007 at 11:27:00AM -0400, Leisner, Martin wrote:
> > Is there support for MPC8220 in current kernels?
>=20
> 8220? Are you sure? That part doesn't exist on the freescale site.
>=20
> Robert=20
> --=20
>  Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>    Handelsregister:  Amtsgericht Hildesheim, HRA 2686
>      Hannoversche Str. 2, 31134 Hildesheim, Germany
>    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
>=20
>=20
