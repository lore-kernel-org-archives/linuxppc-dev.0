Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0F881DDF90
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 18:00:01 +1100 (EST)
Date: Mon, 15 Dec 2008 17:59:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/16] powerpc/fsl-booke: Fix problem with _tlbil_va
Message-Id: <20081215175953.aeb8d836.sfr@canb.auug.org.au>
In-Reply-To: <20081215054518.EC239DDFED@ozlabs.org>
References: <1229319836.100184.344640589620.qpush@grosgo>
	<20081215054518.EC239DDFED@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__15_Dec_2008_17_59_53_+1100_7kZO/u90csMwFjFT"
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__15_Dec_2008_17_59_53_+1100_7kZO/u90csMwFjFT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Mon, 15 Dec 2008 16:44:21 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> From: Kumar Gala <galak@kernel.crashing.org>
>=20
> An example calling sequence which we did see:

This one is already in Linus' tree as of today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__15_Dec_2008_17_59_53_+1100_7kZO/u90csMwFjFT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklGAGkACgkQjjKRsyhoI8wPLgCgoR37obgLGQk2TH/RqUVqwfwY
fQwAn1jdnUA1Rzi1xyN7OcXF2iOrUcnr
=HlZz
-----END PGP SIGNATURE-----

--Signature=_Mon__15_Dec_2008_17_59_53_+1100_7kZO/u90csMwFjFT--
