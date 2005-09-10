Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 10 Sep 2005 20:12:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: jdl@freescale.com
Message-Id: <20050910201222.6861b172.sfr@canb.auug.org.au>
In-Reply-To: <E1EDqf2-0001Rh-Da@jdl.com>
References: <E1EDqf2-0001Rh-Da@jdl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__10_Sep_2005_20_12_22_+1000_BYlG4JB3jIrNjE3W"
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH ppc Merge asm-ppc*/posix_types.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__10_Sep_2005_20_12_22_+1000_BYlG4JB3jIrNjE3W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Sep 2005 16:43:52 -0500 jdl@freescale.com wrote:
>
> +#ifdef __powerpc64__
> +typedef unsigned long  	__kernel_nlink_t;
> +typedef int             __kernel_ipc_pid_t;
> +typedef unsigned long	__kernel_size_t;
> +typedef long		__kernel_ssize_t;
> +typedef unsigned long	__kernel_old_dev_t;
> +#else
> +typedef unsigned short	__kernel_nlink_t;
> +typedef short		__kernel_ipc_pid_t;
> +typedef unsigned int	__kernel_size_t;
> +typedef int		__kernel_ssize_t;
> +typedef unsigned int	__kernel_old_dev_t;
> +#endif

On 32 bit, int =3D=3D long, so the last three could be removed from the ifd=
ef
by making them {unsigned }long ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__10_Sep_2005_20_12_22_+1000_BYlG4JB3jIrNjE3W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDIrGOFdBgD/zoJvwRAm8dAJ45U96Xjaf78qA2MMIkJy04LsS34QCfd/i9
8L3wp6V5RUPEWnP+roNyQus=
=N1RV
-----END PGP SIGNATURE-----

--Signature=_Sat__10_Sep_2005_20_12_22_+1000_BYlG4JB3jIrNjE3W--
