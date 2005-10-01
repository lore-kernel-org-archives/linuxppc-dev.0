Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 1 Oct 2005 22:30:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20051001223028.56ef9bfd.sfr@canb.auug.org.au>
In-Reply-To: <20051001213753.52d5d5c3.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
	<20051001000001.1f1d8c48.sfr@canb.auug.org.au>
	<52E29A49-AAF2-4E61-AAB2-CD02ABCBE447@freescale.com>
	<20051001121714.1b5886aa.sfr@canb.auug.org.au>
	<17214.632.655003.750819@cargo.ozlabs.ibm.com>
	<20051001213753.52d5d5c3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__1_Oct_2005_22_30_28_+1000_vvDg/JZT/k4DOcEh"
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/9] powerpc: merge idle_power4.S and traps.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__1_Oct_2005_22_30_28_+1000_vvDg/JZT/k4DOcEh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 1 Oct 2005 21:37:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> OK, thanks for keeping me honest :-)  Here is new versions of patches 6
> and 7 (all the rest are the same as before).

Just in case anyone is wondering, the new patchset has been built for (my
configs) pSeries, iSeries, g5, ARCH=3Dppc, ARCH=3Dpowerpc ppc32 pmac,
ARCH=3Dpowerpc iSeries and I have booted the ARCH=3Dpowerpc iSeries kernel.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__1_Oct_2005_22_30_28_+1000_vvDg/JZT/k4DOcEh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPoFkFdBgD/zoJvwRAgVwAJ0fh6Nb8d0woEbmaoadPM7SNBX5hwCghV20
/o+VBhi1164kZeKL4DnXRXY=
=njbw
-----END PGP SIGNATURE-----

--Signature=_Sat__1_Oct_2005_22_30_28_+1000_vvDg/JZT/k4DOcEh--
