Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9D77BB719B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 12:01:13 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D076DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 12:01:13 +1000 (EST)
Subject: Re: [PATCH 00/33] My PS3-specific patches for 2.6.31
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1244684128.5739.30.camel@pasglop>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244670213.3352.11.camel@pasglop>  <4A302B67.4000401@mlbassoc.com>
	<1244681320.5739.5.camel@pasglop> <1244683951.4674.5.camel@concordia>
	<1244684128.5739.30.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-VM4UiT9Z2DNRq/Q29z0y"
Date: Thu, 11 Jun 2009 12:01:12 +1000
Message-Id: <1244685672.4674.10.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Gary Thomas <gary@mlbassoc.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-VM4UiT9Z2DNRq/Q29z0y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-06-11 at 11:35 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2009-06-11 at 11:32 +1000, Michael Ellerman wrote:
> > The way I think of it is that the "merge window" is the time for
> > maintainers to merge with Linus.
> >=20
> > So if you're sending patches to a maintainer you need to have sent all
> > your patches to them _before_ then. So the merge window for you is the
> > weeks prior to the "merge window".
>=20
> Right. But a patch generally needs time to be reviewed, spun several
> times, etc... so just the week before the merge window is probably too
> late :-)

Sure. I mean that's when you should be sending polished code that's
ready to merge. In the same way that the maintainers are sending
polished ready to merge code to Linus during the merge window.

But absolutely, most patches need to be reviewed at least once before
they're ready, which is probably a week at best.


But really people should just be sending patches ASAP, even if they're
not 100% finished, so they get as much exposure as early as possible.

Sitting on patches waiting for the "right time" to send them is the
wrong approach IMHO.

cheers

--=-VM4UiT9Z2DNRq/Q29z0y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkowZWgACgkQdSjSd0sB4dJGbACfdNsAq9grCvDBQVflSOC3cgqG
8gEAoL3ZGX5K9eOi/WtADJ5zIVE+tdwl
=A8zC
-----END PGP SIGNATURE-----

--=-VM4UiT9Z2DNRq/Q29z0y--
