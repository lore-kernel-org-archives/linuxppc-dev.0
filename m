Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 2 Sep 2005 16:37:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@freescale.com>
Message-Id: <20050902163708.12c1abe3.sfr@canb.auug.org.au>
In-Reply-To: <1125607912.16685.111.camel@cashmere.sps.mot.com>
References: <1125607912.16685.111.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__2_Sep_2005_16_37_08_+1000_nIkVdF1rQyKTBvKD"
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: PATCH Merge more include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__2_Sep_2005_16_37_08_+1000_nIkVdF1rQyKTBvKD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 01 Sep 2005 15:51:52 -0500 Jon Loeliger <jdl@freescale.com> wrote:
>
> This patch merges several include files from
> asm-ppc and asm-ppc64 into the new asm-powerpc.
>=20
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

> +#ifndef _POWERPC_BUGS_H

I would use _ASM_POWERPC_... but that is just me.

Looks good.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__2_Sep_2005_16_37_08_+1000_nIkVdF1rQyKTBvKD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDF/MUFdBgD/zoJvwRAtgDAJ9xRJvNZSxaGBD3bAuLX5fU/uqMkACeKMmu
ZD16OwGWhrpBnwXf6qBWEWM=
=7Y34
-----END PGP SIGNATURE-----

--Signature=_Fri__2_Sep_2005_16_37_08_+1000_nIkVdF1rQyKTBvKD--
