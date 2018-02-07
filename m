Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zc1WG4bdKzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 23:54:48 +1100 (AEDT)
Date: Wed, 7 Feb 2018 13:54:34 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 linux-gpio@vger.kernel.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Albert Herranz <albert_herranz@yahoo.es>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 3/6] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180207125434.d7wogzlkfthzob5t@latitude>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-4-j.neuschaefer@gmx.net>
 <CACRpkdZLiw=e-XiS9cbQuJGJ2tJVV86qKaLCy2yG==FSENhAHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k64rgg4kcmxdkt7v"
In-Reply-To: <CACRpkdZLiw=e-XiS9cbQuJGJ2tJVV86qKaLCy2yG==FSENhAHw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--k64rgg4kcmxdkt7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 01:29:45PM +0100, Linus Walleij wrote:
> On Mon, Jan 22, 2018 at 6:04 AM, Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>=20
> > The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> > that supports a configurable number of pins (up to 32), interrupts, and
> > some special mechanisms to share the controller between the system's
> > security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> > not supported.
> >
> > This patch adds a basic driver for this GPIO controller. Interrupt
> > support will come in a later patch.
> >
> > This patch is based on code developed by Albert Herranz and the GameCube
> > Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> > available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> > has grown quite dissimilar.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Cc: Albert Herranz <albert_herranz@yahoo.es>
> > Cc: Segher Boessenkool <segher@kernel.crashing.org>
> > ---
> >
> > v2:
>=20
> All looks very good to me, Andy had some additional comments,
> once addressed in v3 I will apply this.
>=20
> You only need to resend this patch as I already applied the DT
> bindings.

This driver can't be used until the resource mapping problem on PPC32
(see patch 1/6 and the related discussion) is solved or worked around
with out-of-tree patches (such as patch 1/6). Should I send v3 anyway?


Thanks,
Jonathan Neusch=C3=A4fer

--k64rgg4kcmxdkt7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJaevcCAAoJEAgwRJqO81/b+8AP/1ktieY5QgM4XqJ854jjrcr1
os/BTiYn6I9sxipwbqGwy48eqAoDJKoFrJBYklkSkRtS0141RLozcU0ImtLRvx8k
feGqYgHG6SINHXrUObmlVNbt3InwHXtl455m2bHAovrwdWrKh4fucVf7Yg7VwO2w
THVQIXwzGuoFxzbnLLHl+DRnUTbAOtwwSQN2pQ8QzFXVkbtwm0U80ZRkm8+2HmBe
mfrA6Av3H1/9HTtbp6Plx9SVsC4ZFUnzXsIiUlO9zAfhe/vfGJy4DkUgovEY2YGX
pWHmN9V1fQgzSYfgvqRwQx6Uis7JYDgEnT3hiZd98bddNWUG3vAGMGPjomgYSSIw
XPVQDNbOU8rP5VcOdLlQS+LQybl3nUL9It1Pei2GvC1oLCshXg2TNbpLcK6alf0v
19kwP7IAW9F4JH9QEnH2yQVdJZTHV8XSw9IYxALyOuzvnmrgd6dAhplx2EL4TbPT
2L+oY0qYtl5zOluKZ6sLmYD2ZLK0WiehVTRqjvu25TrKXu352fJyOPrmFCnfTCDt
K6nTS+JBVgVLTNbopdj/1bRLdRym5bljmpVQjbnjcHhY8RiVHntImsDKZIt0tq7W
qgaCGoNGRFt21Kb28quNuhhdzVxhz70kzPUHsEBbopAFh0LeKdrNloB9jfgxANG0
ccu2K8aRsheyqEjnkP/K
=OU8F
-----END PGP SIGNATURE-----

--k64rgg4kcmxdkt7v--
