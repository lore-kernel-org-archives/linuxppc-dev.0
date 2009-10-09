Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 3C12BB7B7A
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Oct 2009 03:21:11 +1100 (EST)
Date: Fri, 9 Oct 2009 18:20:20 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Message-ID: <20091009162020.GB588@pengutronix.de>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
	<20091009051409.GA2361@pengutronix.de>
	<fa686aa40910082240w7fb2a194tcc80e7afe182e781@mail.gmail.com>
	<1255096871.16018.49.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
In-Reply-To: <1255096871.16018.49.camel@localhost.localdomain>
Cc: devicetree-discuss@ozlabs.org, linux-embedded@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I can submit that soon,  but it probably makes sense for Wolfram to
> voice whatever his concerns were about "questionable" properties before
> I document what's there.

Please don't feel offended. The things I noticed are:

a) no documentation

b) 'polarity' is a direct mapping to the register which IMO is a hint to lo=
ok
closer. I haven't checked in detil, but maybe the active_low-flag could be =
used
for this?

I mainly got alarmed that properties were mainlined without being reviewed;=
 as
the device-tree is based on convention (which is hard to change afterwards)=
, I
try to make sure this will not so easily happen again (thus the
get_maintainer-patch on lkml).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrPYsQACgkQD27XaX1/VRvaWgCgvUNhJqjS+Ukr6FpnNyea2kOe
ng8An12HR1WAnkJJd43Fyf4VDUcvM5Wl
=YsSA
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
