Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Consolidate obj-y assignments
From: Michael Ellerman <michael@ellerman.id.au>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <87y694z3b8.fsf@macbook.be.48ers.dk>
References: <0429b4b15a3c65fdae92f92cce656b4859dca05e.1289190214.git.michael@ellerman.id.au>
	<87y694z3b8.fsf@macbook.be.48ers.dk>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-cKQlD0ZBBlnrTKAJXuA3"
Date: Tue, 09 Nov 2010 12:25:52 +1100
Message-ID: <1289265952.21111.34.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-cKQlD0ZBBlnrTKAJXuA3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-11-08 at 08:23 +0100, Peter Korsgaard wrote:
> >>>>> "Michael" =3D=3D Michael Ellerman <michael@ellerman.id.au> writes:
>=20
>  Michael> No need to have three of them.
>  Michael> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>  Michael> ---
>  Michael>  arch/powerpc/kernel/Makefile |    9 ++++-----
>  Michael>  1 files changed, 4 insertions(+), 5 deletions(-)
>=20
>  Michael> -		        signal.o sysfs.o cacheinfo.o
>  Michael> -obj-y		+=3D vdso32/
>  Michael> +			signal.o sysfs.o cacheinfo.o time.o \
>  Michael> +			time.o prom.o traps.o setup-common.o \
>=20
> You have time.o twice.

Yeah, it makes the kernel run twice as fast.

cheers



--=-cKQlD0ZBBlnrTKAJXuA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzYox0ACgkQdSjSd0sB4dJmbgCgx+MQ1KPR9JPONyOsOVLqxO6b
XboAn30dRxhvCLDbYsKh3wUo1KpL809A
=oGo8
-----END PGP SIGNATURE-----

--=-cKQlD0ZBBlnrTKAJXuA3--
