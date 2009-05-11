Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AACCEDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 12:00:04 +1000 (EST)
Subject: Re: device trees.
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-u9N58I8vqcDKDW3rDaqO"
Date: Mon, 11 May 2009 12:00:03 +1000
Message-Id: <1242007203.7767.28.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dhlii@dlasys.net
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-u9N58I8vqcDKDW3rDaqO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2009-05-09 at 14:51 -0600, Grant Likely wrote:
> On Fri, May 8, 2009 at 10:03 AM, David H. Lynch Jr. <dhlii@dlasys.net> wr=
ote:
> >    Is there an example somewhere that shows building a device tree on
> > the fly ?
> >
> >    As our products move forward it becomes increasingly clear that
> > static configurations are not going to work.

> To use device tree with partial reconfiguration would require rework
> to the device tree infrastructure to prune and graft portions of the
> device tree.  I think it is possible, but it is non-trivial to get
> working.

arch/powerpc/platforms/pseries/reconfig.c

Not pretty, but it does more or less what you're talking about. Would
need some work to get it going on !pseries obviously.
=20
cheers

--=-u9N58I8vqcDKDW3rDaqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoHhqMACgkQdSjSd0sB4dJCzwCgwomkyQhChxfFpCgMDSw/r3ca
8owAoKancwpJq+T7mL2NWcib0kEQjzGF
=mFT5
-----END PGP SIGNATURE-----

--=-u9N58I8vqcDKDW3rDaqO--
