Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 388C167A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 02:41:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 5 Apr 2005 11:41:10 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859338@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Stefan Nickl" <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks....

That whole patch works beautifully.
Had to apply the whole thing (so fcc_restart gets called in the start,
and end of fcc_open) for it to work.

Without calling fcc_restart in the start, I get lots of "eth0: tx queue
full!." messages.

> -----Original Message-----
> From: Stefan Nickl [mailto:Stefan.Nickl@kontron.com]=20
> Sent: Tuesday, April 05, 2005 10:57
> To: Rune Torgersen
> Cc: linuxppc-embedded
> Subject: Re: FCC Ethernet startup crash
>=20
> On Tue, 2005-04-05 at 10:37 -0500, Rune Torgersen wrote:
> > I've been running into the old problem of the kernel ip=20
> stack crasheing
> > the kernel, because of early packets again.
> >=20
> > This has been mentioned on this list several times before, but the
> > worarounds that used to work doesn't seem to work anymore.
> > (like changing the order of things in ip_init())
> >=20
> > As far as I can tell, it is because the FCC enet drivers starts to
> > receive packets way before the ip stack is initialized.
> >=20
> > Does anybody have any good ideas on how to fix this?
>=20
> Maybe you want to try my version:
>=20
> http://ozlabs.org/ppc32-patches/patch.pl?id=3D14
>=20
> Or is it equal to your (no longer working) solution?
>=20
> --=20
> Stefan Nickl
> Kontron Modular Computers
>=20
>=20
>=20
>=20
