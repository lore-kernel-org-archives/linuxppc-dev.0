Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DE3AD68A9A
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 21:16:38 +1100 (EST)
Date: Wed, 8 Feb 2006 21:16:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olh@suse.de>
Subject: Re: asm-powerpc/highmem.h missing
Message-Id: <20060208211600.28252f22.sfr@canb.auug.org.au>
In-Reply-To: <20060208093439.GA9240@suse.de>
References: <20060208093439.GA9240@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__8_Feb_2006_21_16_00_+1100_KP+Ppi3aAbm2K=Q3"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__8_Feb_2006_21_16_00_+1100_KP+Ppi3aAbm2K=Q3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Feb 2006 10:34:39 +0100 Olaf Hering <olh@suse.de> wrote:
>
>=20
> Why was asm-ppc/highmem.h not migrated? linux/highmem.h and pagemap.h wan=
ts it.

I guess it was not migrated because it is only required for CONFIG_HIGHMEM
and, of course, ppc64 does not need HIGHMEM and presumably noone has tried
to build with CONFIG_HIGHMEM set in ARCH=3Dpowerpc until now.

Patches accepted :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Feb_2006_21_16_00_+1100_KP+Ppi3aAbm2K=Q3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD6cTmFdBgD/zoJvwRAppvAKCRdlDeXbkGLPWg4iIXayzdtXtv+wCeLpuc
t8oqcnvxz4HgLBu5AbR62Qk=
=b7j5
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Feb_2006_21_16_00_+1100_KP+Ppi3aAbm2K=Q3--
