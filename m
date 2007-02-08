Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1EBFDDEDA
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:13:37 +1100 (EST)
Subject: Re: [PATCH 10/12] powerpc: remove unneeded exports in mem.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17866.42529.436809.257415@cargo.ozlabs.ibm.com>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124614.830282000@sipsolutions.net>
	<17866.42529.436809.257415@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ct+vjF7HD9KnPiLCeam9"
Date: Thu, 08 Feb 2007 14:10:53 +0100
Message-Id: <1170940253.4385.44.camel@johannes.berg>
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


--=-ct+vjF7HD9KnPiLCeam9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-08 at 15:25 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > arch/powerpc/mm/mem.c exports page_is_ram and phys_mem_access_prot whic=
h
> > both are not used anywhere that could be modular.
>=20
> phys_mem_access_prot is used in drivers/video/fbmem.c, and the fb
> stuff can be a module.

Ouch, sorry, the Makefile there with fb-y confused me. Seems all these
patches have one problem or another :(

I'll repost just the removal of page_is_ram then.

johannes

--=-ct+vjF7HD9KnPiLCeam9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFyyFd/ETPhpq3jKURAnG3AJ0RuqjhNObIKx8t3+94mlVfKcm9SgCgghpy
6OD5XGwPDkS3wxJgNPrkKZo=
=oxPE
-----END PGP SIGNATURE-----

--=-ct+vjF7HD9KnPiLCeam9--
