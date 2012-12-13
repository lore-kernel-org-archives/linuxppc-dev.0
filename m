Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 04E962C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 12:06:54 +1100 (EST)
Message-ID: <1355360782.5526.20.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH v3] powerpc: fix wii_memory_fixups() compile error on
 3.0.y tree
From: Ben Hutchings <ben@decadent.org.uk>
To: shuah.khan@hp.com
Date: Thu, 13 Dec 2012 01:06:22 +0000
In-Reply-To: <1355354871.2722.38.camel@lorien2>
References: <1354932445.7407.15.camel@lorien2>
 <1354987359.20838.67.camel@deadeye.wl.decadent.org.uk>
 <CAKocOOPYv0L5dnVJ-jcKw6u3Axbe-tFRdz+F8FvE6fq-xRQH5A@mail.gmail.com>
 <1355160196.2739.12.camel@lorien2> <20121210185527.GI13292@decadent.org.uk>
 <1355270698.2616.44.camel@lorien2> <1355354871.2722.38.camel@lorien2>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-wLR7pbB3FyxMpBngfxA1"
Mime-Version: 1.0
Cc: stable <stable@vger.kernel.org>, paulus@samba.org, shuahkhan@gmail.com,
 Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-wLR7pbB3FyxMpBngfxA1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-12-12 at 16:27 -0700, Shuah Khan wrote:
> Fix wii_memory_fixups() the following compile error on 3.0.y tree with
> wii_defconfig on 3.0.y tree.
>=20
>   CC      arch/powerpc/platforms/embedded6xx/wii.o
> arch/powerpc/platforms/embedded6xx/wii.c: In function =E2=80=98wii_memory=
_fixups=E2=80=99:
> arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format =E2=80=98%ll=
x=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=
=99, but argument 2 has type =E2=80=98phys_addr_t=E2=80=99 [-Werror=3Dforma=
t]
> arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format =E2=80=98%ll=
x=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=
=99, but argument 3 has type =E2=80=98phys_addr_t=E2=80=99 [-Werror=3Dforma=
t]
> arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format =E2=80=98%ll=
x=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=
=99, but argument 2 has type =E2=80=98phys_addr_t=E2=80=99 [-Werror=3Dforma=
t]
> arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format =E2=80=98%ll=
x=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=
=99, but argument 3 has type =E2=80=98phys_addr_t=E2=80=99 [-Werror=3Dforma=
t]
> cc1: all warnings being treated as errors
> make[2]: *** [arch/powerpc/platforms/embedded6xx/wii.o] Error 1
> make[1]: *** [arch/powerpc/platforms/embedded6xx] Error 2
> make: *** [arch/powerpc/platforms] Error 2
>=20
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> CC: stable@vger.kernel.org 3.0.y
[...]

This looks fine, and I've queued it up for 3.2 since the errant code
wasn't removed until 3.3.

Ben.

--=20
Ben Hutchings
Theory and practice are closer in theory than in practice.
                                - John Levine, moderator of comp.compilers

--=-wLR7pbB3FyxMpBngfxA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUMkqDue/yOyVhhEJAQpptRAAkdjKgWlmbaHbeF8DYi4tkfHfUPXfR6WG
Xrafo4fR9D3RObvU1xOHrRkPxvNhLj45IVL3G2DzbFOc6wPLHKBiKbmk+PhN3c7v
pP7+uwu7NYhU65kG21sYwm2HGmpV54kGAc/V/JWL9VXJATEtLhq7p3026rolLW68
CNpLYH1CPwksQFVTNTgwKcN63CFgqb+KO0Xy4FwI4Cuj3OCigvkQzggDuafwQr8x
k3Q90KoKgjnM+Y+GaNJfvoVbGnzJIkS3p2z9TzPRys5yYJGA2QfL6UJZYMt+m2Ft
MXqvHYmcqoLw/QGsowipikSqIf5niNdCqROJhkVcQs7arWUaIha74qu9KP0o89kR
PgBMZMdQZZnomWnDc/excW4IQWrZKYBc9/PUUp4Jc8VQ0PYnmPrLaB2QcU3SaEr/
6PPHDkVvBtOb5cj+jBVGMOaKwqVVQFEtWqyl+2Aj2DkET+5GCcH+mtw73nOzrIbE
AF1c3/f4Lqcnej86mh7S3qH474s7bkOkRNSUQr4yGASPJMAz+bv9Iu0jz8ge8RZT
uEXxRK+879rRI7j+tvuDE68se1CE+DlYq72r+SNWmvGKCcLO/gqGA+/3iDTTQ0Io
HzCarqw3rSVy3RQhnWUgzyrOhQyzA3NCIa0c7RYVMAuPJE5IgFncfR9UtFI+ZiAP
bKRV8gc5cL0=
=XVua
-----END PGP SIGNATURE-----

--=-wLR7pbB3FyxMpBngfxA1--
