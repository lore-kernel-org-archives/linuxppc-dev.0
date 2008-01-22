Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 23 Jan 2008 01:38:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] Convert axon_msi to an of_platform driver
Message-Id: <20080123013817.38db9ac6.sfr@canb.auug.org.au>
In-Reply-To: <c04b1ca531fcd78c42c5a13802c1c331f9b4c8a7.1200999872.git.michael@ellerman.id.au>
References: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1200999872.git.michael@ellerman.id.au>
	<c04b1ca531fcd78c42c5a13802c1c331f9b4c8a7.1200999872.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jan_2008_01_38_17_+1100_4epogkACdbO77CJ2"
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jan_2008_01_38_17_+1100_4epogkACdbO77CJ2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, 22 Jan 2008 22:04:40 +1100 (EST) Michael Ellerman <michael@ellerman=
.id.au> wrote:
>
> +#include <asm/of_platform.h>

You must have missed the lectures :-) Please use linux/of_platform.h

> +static struct of_device_id axon_msi_device_id[] =3D {

const, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_01_38_17_+1100_4epogkACdbO77CJ2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlf/eTgG2atn1QN8RAoTcAJ4qQeo2lXFkUPL83s1lKt5WZAzSZwCdGT80
ox5w1GrNQGgzd0spiTVEgmU=
=1tC7
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_01_38_17_+1100_4epogkACdbO77CJ2--
