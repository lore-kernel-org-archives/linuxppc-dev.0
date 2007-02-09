Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF112DDE30
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 02:38:58 +1100 (EST)
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1170973463.2620.373.camel@localhost.localdomain>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170973463.2620.373.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nqCFb1BSS6H2DfgtGVAw"
Date: Fri, 09 Feb 2007 16:36:22 +0100
Message-Id: <1171035382.4520.7.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nqCFb1BSS6H2DfgtGVAw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-09 at 09:24 +1100, Benjamin Herrenschmidt wrote:

> Or we can just mark interrupts as soft-disabled ?

The power4 nap function enables both so we'd have to change some things
around there. Probably a better idea though.

johannes

--=-nqCFb1BSS6H2DfgtGVAw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFzJT2/ETPhpq3jKURAlVTAJ4iXUg9xA6jU5z+3mTTitXdGp7fbQCaAjlz
tlrdpQFZl7NhgkEZUXrGjs0=
=V17U
-----END PGP SIGNATURE-----

--=-nqCFb1BSS6H2DfgtGVAw--
