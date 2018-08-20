Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 41v7TJ0qZrzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 19:16:03 +1000 (AEST)
Date: Mon, 20 Aug 2018 11:07:18 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Darren Stevens <darren@stevens-zone.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND PATCH] i2c/busses/pasemi: Remove hardcoded bus numbers
 on smbus
Message-ID: <20180820090718.eb4kgadzg7qevqrx@ninjato>
References: <4b3d0f2cad0.58555470@auth.smtp.1and1.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="c47ohostxojzrm6n"
In-Reply-To: <4b3d0f2cad0.58555470@auth.smtp.1and1.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--c47ohostxojzrm6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2017 at 08:53:55PM +0000, Darren Stevens wrote:
> The pasemi smbus controller uses PCI_FUNC(dev->devfn) to define which
> number bus to attach to, however this fails when something else is=20
> probed first, for example an ATI Radeon graphics card will claim 9 or
> 10 busses, including the ones the pasemi wants.
> Patch the driver to call i2c_add_adapter rather than
> i2c_add_numbered_adapter.
>=20
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
>=20

Applied to for-next, thanks!

Disclaimer: I usually do not like to change the bus numbering because
some people may rely on that. But numbering based on PCI functions seems
really weak and all known users of pasemi seem to have issues here, so I
make an exception.

Thanks to Michael Ellerman for the additional info.


--c47ohostxojzrm6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6hMYACgkQFA3kzBSg
KbYBqg/9EWQNUMoeNhGwRrKaMNO33hZCrOpJxvlEanmPyfFGddCNh4+bIqHbA0rs
i/XVqdHCa1gtRCxh2x67dnt9UMcW1Ftq//cgWeEu+oDBYHj1EvLtBx1jUdnuq3OY
UEkKZXUagPAiYE7o4NvhfAG0Uw3TdhGFWvJkQft1h5aOrtQjqmOqoMzbra0MgbCq
49auz5PomKjRDcKsJs+sDM0OAjisElsFAD9O2nbFJA5/Fr2eymN5uWtb4lGmJuxq
0+Yd0ThvROSULc+9XusvqFw27Jh8ShShZR7+QyPy5m/gm9j/YDxpw3lPKupAb9K+
11QJotldy2JkqUwv/d7BWdhj+8qBPcqekbqot4yy6jhBOugfF6lWflDe/nJ1TNcM
gtK8IES5BwkGL+uxQkpF4pZyQ1Cp/PN1N0ADVXi9xoQbF2YVwESbgC8BG8l4hsuk
NfV4HqDV6qAVzDtCSRfKi4FHJMvb5ThM1rz9hz1XBylK3anAnauZXBA7UZwiIWUh
UKCfbm9IUjVruvaLOUAMI6yVabnMWGgAFbbvDdZHqpVr5Ps0icijVTrqLKLGzuZ2
0u8YLlWgSZfeenkj6tJ7P9wmLRropMSxmmb4rqBN08x6iZWRSrEynuQt1FbQbUwz
VvDaRpQY6d9XrNu4yNOx+D52+3MoGPOlDQDH1m/eIFp+sWPAp58=
=4t8c
-----END PGP SIGNATURE-----

--c47ohostxojzrm6n--
