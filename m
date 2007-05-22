Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47E3FDDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 19:02:11 +1000 (EST)
Subject: Re: [PATCH 07/13] Implement arch disable/enable irq hooks.
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1179818066.32247.812.camel@localhost.localdomain>
References: <20070507182950.GF26920@ld0162-tx32.am.freescale.net>
	<1179762902.9122.19.camel@johannes.berg>
	<1179818066.32247.812.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-IeNmZnchNYC8V/K/B2nq"
Date: Tue, 22 May 2007 11:03:09 +0200
Message-Id: <1179824589.3673.1.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-IeNmZnchNYC8V/K/B2nq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-22 at 17:14 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-05-21 at 17:55 +0200, Johannes Berg wrote:
> >=20
> > Then again, if we don't implement these in common code, might we get
> > link problems when we try building some multiplatform kernel?
>=20
> That's what ppc_md is for :-)

So you're saying we should globally implement
arch_suspend_irq_{enable,disable} and then call some ppc_md hook? Sounds
good to me as well, I'd like to ask for a revision of this patch
including that, then I'll update my patches for that.

johannes

--=-IeNmZnchNYC8V/K/B2nq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGUrHN/ETPhpq3jKURAq1WAKC1zVbBtIdl+UMkpwFpuJqIq1K71wCffYoV
YMkuHcdLEnGg3U88ygCA16E=
=UsD6
-----END PGP SIGNATURE-----

--=-IeNmZnchNYC8V/K/B2nq--
