Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 23 Nov 2011 14:21:57 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: 44x: Add mtd ndfc to the ppx44x defconfig
Message-ID: <20111123032155.GC25264@thor.bakeyournoodle.com>
References: <20111122234933.GA28400@thor.bakeyournoodle.com>
 <CA+5PVA7js5kmK3JGDKiYa+xVqojmM2ZedifPHHWFsY7CYrqzYA@mail.gmail.com>
 <1322012084.14573.19.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
In-Reply-To: <1322012084.14573.19.camel@pasglop>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2011 at 12:34:44PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2011-11-22 at 20:04 -0500, Josh Boyer wrote:
> > On Tue, Nov 22, 2011 at 6:50 PM, Tony Breeds <tony@bakeyournoodle.com> =
wrote:
> > > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> >=20
> > Acked-by: Josh Boyer <jwboyer@gmail.com>
> >=20
> > Ben, I don't have anything particularly urgent for 3.2 and this seems
> > like it is well within the 3.2 window (defconfig updates usually come
> > later).  Want to pick this up yourself, or do you want me to prep a
> > tree somewhere?
>=20
> I'm working on 3.3 right now, so I'd rather you throw this in there, I
> doesn't seem to be particularily urgent for 3.2 is it? (who actually
> uses 4xx_defconfig ?)

It's mostly for linux-next / kisskb

There was a compiler error added to ndfc in upstream[1].  The change was in
linux-next but nothing currently builds that code.  If we update
4xx_defconfig then linux-next will catch errors sooner.

So it's not urgent, but it doesn't hurt

[1] http://patchwork.ozlabs.org/patch/127000/

Yours Tony

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOzGbTAAoJEEsCiJRY75GKYXoP/0C9wkEVguHJk0WL4+zqZH/a
2Ug3i78GLQzm4QAwWMkLJ8jPHc8dqxP/ltceJPSzR64eXevbz8PC74ThKnuYRYZh
izOEMhbtzZ8h5xjQvYi+dmWgyEW25bokyxNtA3Yz7I2IapiGOoDyIQFTo2ujIByJ
zdPKsFunW4YD/ARmolxwljIDqgrB3Cd3LHAzie6TbI0cUdz/GdjQyFImIy4HjTJ2
q6JKdOa9ib+KCIsBfmy3YeqZmqorKNMEaqWIosn1Eno5vl/cjVf0ka3RIYXHIyNY
zSQkaKHs0ozSd7Rn7qqPYE+yvkWHmhcBQEFmr2iNL/yQezwSULYW1UWxz9hCzZLt
9/KwEkSpOKgkC/3B8u5OstOaVcGqAzcYLYjFGEIsmcg9QMmFmD9QeFMpNwZJdK8Q
PF+AlAJGmSXgEpWTPLhnr+ry9UHRC5F2rR9fyuGqwU6ulpVQ+5FkPakoHBqaBTxi
bJP5fXCUUkFuCDihAO+JQ3//BOJqFF6sOpNI/ZDZS6VBxtKviwtZSpB0u/CKbXaw
nO4pQMsd+48NMmnaMMkuU4Px35zQwRj5+0CanOA1nwxQtScwwVuzBf1TiDgX9JaU
BALtNhYORCU4kY77dgkRbwLgEIGonnEbi0HW5HolB5dvnKS3mI9sJIcwk72VXcvw
3VpTXzVG/+cmkWZ1c8L5
=/TDZ
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
