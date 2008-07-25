Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 35399DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 14:13:41 +1000 (EST)
Date: Fri, 25 Jul 2008 14:13:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: linux-next: kbuild tree build failure
Message-Id: <20080725141330.c58e0a07.sfr@canb.auug.org.au>
In-Reply-To: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__25_Jul_2008_14_13_30_+1000_0ZtDO6qI53KCAVxo"
Cc: Benjamin, Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Mackerras <paulus@samba.org>, Paul
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__25_Jul_2008_14_13_30_+1000_0ZtDO6qI53KCAVxo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Mon, 7 Jul 2008 18:40:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:
>=20
> arch/powerpc/platforms/cell/spu_base.c: In function '__spu_trap_data_seg':
> arch/powerpc/platforms/cell/spu_base.c:194: error: duplicate case value
> arch/powerpc/platforms/cell/spu_base.c:177: error: previously used here

This still fails in linux-next today.  We need some solution before you
send these commits to Linus.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Jul_2008_14_13_30_+1000_0ZtDO6qI53KCAVxo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiJUusACgkQjjKRsyhoI8xkYACgmhCRENes9NWIVzQUS1jyLt6X
7LgAnRvpsvjOAMwlflGTEU1ryoEnT92W
=+Bz7
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Jul_2008_14_13_30_+1000_0ZtDO6qI53KCAVxo--
