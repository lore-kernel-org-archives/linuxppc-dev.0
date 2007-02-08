Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD2B1DDEC5
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:06:09 +1100 (EST)
Subject: Re: [PATCH 04/10] powermac: clean up PIC initialisation code
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17866.43496.243710.13852@cargo.ozlabs.ibm.com>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.479588000@sipsolutions.net>
	<17866.43496.243710.13852@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-h2XYojNWxR48nSL4beV/"
Date: Thu, 08 Feb 2007 14:03:18 +0100
Message-Id: <1170939798.4385.38.camel@johannes.berg>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-h2XYojNWxR48nSL4beV/
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-08 at 15:41 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
> > This patch cleans up the powermac PIC initialisation code so that for G=
5
> > powermacs we don't even compile the old pmac pic file.
>=20
> On a 32-bit powermac config, with this patch I get:
>=20
>   CC      arch/powerpc/platforms/powermac/mpic.o
> /home/paulus/kernel/powerpc/arch/powerpc/platforms/powermac/mpic.c: In fu=
nction =E2=80=98pmac_pic_setup_mpic_nmi=E2=80=99:
> /home/paulus/kernel/powerpc/arch/powerpc/platforms/powermac/mpic.c:40: er=
ror: =E2=80=98xmon_action=E2=80=99 undeclared (first use in this function)
> /home/paulus/kernel/powerpc/arch/powerpc/platforms/powermac/mpic.c:40: er=
ror: (Each undeclared identifier is reported only once
> /home/paulus/kernel/powerpc/arch/powerpc/platforms/powermac/mpic.c:40: er=
ror: for each function it appears in.)
> make[3]: *** [arch/powerpc/platforms/powermac/mpic.o] Error 1

Yeah. I noticed that yesterday as well, but too late. Sorry about that.
I could fix but it isn't nice, let's just drop this patch instead.
Sorry.

johannes

--=-h2XYojNWxR48nSL4beV/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFyx+W/ETPhpq3jKURAr5EAJwIXjCSzgqKMFebp6JZgbabiHDWLwCbBlMb
Fs0iC5TE8uf0pWghHYx5mrg=
=FPPj
-----END PGP SIGNATURE-----

--=-h2XYojNWxR48nSL4beV/--
