Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6134DDE3E
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 09:59:08 +1100 (EST)
Subject: Re: [PATCH 02/10] windfarm: dont die on suspend thread signal
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070205145425.5f6ecbb0.akpm@linux-foundation.org>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
	<20070205145425.5f6ecbb0.akpm@linux-foundation.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-74l907ZxJkcCj5mB0+/n"
Date: Mon, 05 Feb 2007 23:55:34 +0100
Message-Id: <1170716134.30959.15.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>,
	linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-74l907ZxJkcCj5mB0+/n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 14:54 -0800, Andrew Morton wrote:

> That sounds like a fairly irritating feature.  Should we backport this in=
to 2.6.20?

It'll apply just fine, but don't bother. No machine that actually uses
this windfarm infrastructure can suspend right now.

johannes

--=-74l907ZxJkcCj5mB0+/n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFx7Xm/ETPhpq3jKURAnddAJ4/EF3dXyMonTuo6eNrdt8JjTgSswCfe5jI
GRpjdHxk+YB7GjXOVOJ++J8=
=hOoM
-----END PGP SIGNATURE-----

--=-74l907ZxJkcCj5mB0+/n--
