Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 51D1DDDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 17:38:29 +1100 (EST)
Date: Thu, 4 Dec 2008 17:38:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc: Rework context management for CPUs with no
	hash table
Message-Id: <20081204173813.fa04b41b.sfr@canb.auug.org.au>
In-Reply-To: <20081204054232.2554CDDE2A@ozlabs.org>
References: <20081204054232.2554CDDE2A@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__4_Dec_2008_17_38_13_+1100_n.1oFL/rV+G.A8wV"
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__4_Dec_2008_17_38_13_+1100_n.1oFL/rV+G.A8wV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 04 Dec 2008 16:41:53 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-04 15:18:46.0=
00000000 +1100
> +	/* No more free contexts, let's try to steal one */
> +	if (nr_free_contexts =3D=3D 0) {
> +#ifdef CONFIF_SMP
               ^
typo

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__4_Dec_2008_17_38_13_+1100_n.1oFL/rV+G.A8wV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk3etUACgkQjjKRsyhoI8wxTACdEEvb+ZznniztoIRgTiMjZYU2
hXYAni35gZ1hF8jFv7JmxZJeTAAs5ery
=B3wr
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Dec_2008_17_38_13_+1100_n.1oFL/rV+G.A8wV--
