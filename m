Return-Path: <tomi.valkeinen@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47B9D1A016F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 19:52:08 +1000 (EST)
Message-ID: <542A7B59.5090607@ti.com>
Date: Tue, 30 Sep 2014 12:43:53 +0300
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] video: valkyriefb: Fix unused variable warning in
 set_valkyrie_clock()
References: <1410688110-11042-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1410688110-11042-1-git-send-email-geert@linux-m68k.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1NdofF1mpinKNkn3WgodjBKWvUoeMNoTD"
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-m68k@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--1NdofF1mpinKNkn3WgodjBKWvUoeMNoTD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/09/14 12:48, Geert Uytterhoeven wrote:
> If CONFIG_ADB_CUDA=3Dn:
>=20
> drivers/video/fbdev/valkyriefb.c: In function =E2=80=98set_valkyrie_clo=
ck=E2=80=99:
> drivers/video/fbdev/valkyriefb.c:267: warning: unused variable =E2=80=98=
i=E2=80=99
> drivers/video/fbdev/valkyriefb.c:266: warning: unused variable =E2=80=98=
req=E2=80=99
>=20
> Move the variable declarations inside the existing #ifdef section to fi=
x
> this.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/video/fbdev/valkyriefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/val=
kyriefb.c
> index 97cb9bd1d1dd..b6ed09f16355 100644
> --- a/drivers/video/fbdev/valkyriefb.c
> +++ b/drivers/video/fbdev/valkyriefb.c
> @@ -263,10 +263,10 @@ static inline int valkyrie_vram_reqd(int video_mo=
de, int color_mode)
> =20
>  static void set_valkyrie_clock(unsigned char *params)
>  {
> +#ifdef CONFIG_ADB_CUDA
>  	struct adb_request req;
>  	int i;
> =20
> -#ifdef CONFIG_ADB_CUDA
>  	for (i =3D 0; i < 3; ++i) {
>  		cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_GET_SET_IIC,
>  			     0x50, i + 1, params[i]);
>=20

Thanks, queued for 3.18.

 Tomi



--1NdofF1mpinKNkn3WgodjBKWvUoeMNoTD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKntZAAoJEPo9qoy8lh71D3sQAJ7iOozTAqEsdQ/r6ccTUbBr
o4rJ4gOxsAdAHCLC7BNVGCa0qFPBAg1sMHxAu9IY/Vm9q/UrtoRe0/cy0YNL5hqa
80JidB9asTWZHaTXvmPJywiOL8nlKwAiB0Z9T9RzRWapfHgclJ2k2i7tSXt2clHQ
/Y80B7he/ZcIrCcySgBxF/nIYweOP+VxQHCIOeXLEkWYk5SwVRgm6RbJPPPv3Qwd
tJQDA/gBgO9sG33TUuMoE8UxJOWGszTb/vUJHEDlPM8wAkZ9NecT9KmA0Xn2Cn+g
MciF3HiUyOuth44jmkjq9UftLAzHEAsmWp3vI6WVdzCyVW4a6A3nbOfuBqklhLfL
Q/lC/nX4oNl4St7suoSw9RtxkbsoAgHHFV1x4/NdyIIuIyj1/FZmR289sz7N+Hzx
ZIVRYuhhDf0jSBQ/XKY1+oExX9rkKhHspE3LEGEhOSq9hjyA9lVFJdh1rxb/V0Jm
6UsxddrJJDsu4WAVqE+/uYqgvKNxm4iTBsod4N9wyCiuqTJ/r3P81Jh4wrGWU5Jr
CbfdoGieDkw/nFr9Bauh7p+rFhtofGV/sWPENvULhNYbZ0cBhtv1OSidMD8+b/XQ
mNVm4w3EOiEgPBFGMaIAA7C3mZ65jbVwOqb2D8yM5AqZj2yHCwDuOrHN1IX6tACd
skyLDleTuRoziCpyDqJX
=AFBL
-----END PGP SIGNATURE-----

--1NdofF1mpinKNkn3WgodjBKWvUoeMNoTD--
