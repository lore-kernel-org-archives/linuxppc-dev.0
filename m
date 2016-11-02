Return-Path: <tomi.valkeinen@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t81kd1hj1zDt53
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:40:08 +1100 (AEDT)
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
To: Mathieu Malaterre <malat@debian.org>, <linux-fbdev@vger.kernel.org>
References: <1475928540-19647-1-git-send-email-malat@debian.org>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
Date: Wed, 2 Nov 2016 10:28:55 +0200
MIME-Version: 1.0
In-Reply-To: <1475928540-19647-1-git-send-email-malat@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RA5rjBMNWoGotpsjdBTS4iHc1R5plmg5p"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--RA5rjBMNWoGotpsjdBTS4iHc1R5plmg5p
Content-Type: multipart/mixed; boundary="9hOgMH0jSQ2NC1DrCHlgIFxMk8ka3sVeO";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Mathieu Malaterre <malat@debian.org>, linux-fbdev@vger.kernel.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
References: <1475928540-19647-1-git-send-email-malat@debian.org>
In-Reply-To: <1475928540-19647-1-git-send-email-malat@debian.org>

--9hOgMH0jSQ2NC1DrCHlgIFxMk8ka3sVeO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/16 15:09, Mathieu Malaterre wrote:
> When the linux kernel is build with (typical kernel ship with Debian
> installer):
>=20
> CONFIG_FB_OF=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_FB_RADEON=3Dm
>=20
> The offb driver takes precedence over module radeonfb. It is then
> impossible to load the module, error reported is:
>=20
> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000=
000-0x9fffffff pref]
> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
>=20
> This patch reproduce the behavior of the module radeon, so as to make i=
t
> possible to load radeonfb when offb is first loaded.
>=20
> It should be noticed that `offb_destroy` is never called which explain =
the
> need to skip error detection on the radeon side.

Why is that? It sounds rather bad if two drivers claim the same resources=
=2E

 Tomi


--9hOgMH0jSQ2NC1DrCHlgIFxMk8ka3sVeO--

--RA5rjBMNWoGotpsjdBTS4iHc1R5plmg5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYGaPHAAoJEPo9qoy8lh71VZgP/iB6GTEKdGS8+akZaJ5BsAKB
7whPZH90q6cAAs0RHHIh3f3LQTCKNhXCwGgI8MeOo/yrp0RorLPz9JZymg8Ltu6a
c0hd2z5X4ztv9Bu19JfjXBMBAMvV5wxilzxUQiZ7vBaR4315DGj7TfMYO4hhs9Ta
0SBFXE77coX5FDrPLvKIl4R90pW/2o7tQzrn/8ei47Z+LQMk9wVUsSmuF0qn2chU
L2L1fYPGmNMy0fVAklZdImGzb2/sKScAcL69C81rDIv2VsJnG9KGGjn8SXS6lDu1
tvSByh1xnrIA+mtg80zcL8mPwKbbQDw2DJnfpei5chU2DKOWC/ArmPPLswpGyCnT
FA86uR9zsXlL/+5XdbuM1Zu68ol9ztp8qtPyQ3W0VBRKnGGjgd3Ly43zHccbGjfU
hV2OkiAswEUEE+GZYWvtAdjaHKr76FT9Fgg1cGLxYrKx5FTM9Sap88J52EzMnESW
zCkz15Cf/rfR2B6QQBBpXHqVCR0GhGvtkxACfKikcANe9jB9TmlB5VuBWyymZeg8
CwDSCYyoogpSvgeYDQTfa3sGdFlFEzcGsgBHwQNH3RyaraMMYpnQGqiwq1eWZeHE
2tphSRzM56O5j9QGteZhSKH1ZktI6UGdwVUSqoji6aQ85vMmghPszLfDlq1eiKWQ
6rUPfaUiXwBo6ItRTVgl
=2pJA
-----END PGP SIGNATURE-----

--RA5rjBMNWoGotpsjdBTS4iHc1R5plmg5p--
