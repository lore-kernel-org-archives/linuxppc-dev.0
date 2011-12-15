Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 15 Dec 2011 22:44:01 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux-next bad Kconfig for drivers/hid
Message-ID: <20111215114401.GA3089@thor.bakeyournoodle.com>
References: <20111209012746.GC20353@thor.bakeyournoodle.com>
 <4EE19DA0.5010705@goop.org>
 <alpine.LNX.2.00.1112120020330.21970@pobox.suse.cz>
 <20111212003140.GA16353@thor.bakeyournoodle.com>
 <alpine.LNX.2.00.1112151107020.21970@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <alpine.LNX.2.00.1112151107020.21970@pobox.suse.cz>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel ML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2011 at 11:08:08AM +0100, Jiri Kosina wrote:
=20
> Tony,
>=20
> have you actually tested this one to work in the configuration you have=
=20
> been seeing it to fail?
>=20
> I don't seem to be able to find any use of '=3D=3D' in other Kconfig file=
s=20
> (and never used it myself), so I'd like to have confirmation that it=20
> actually works and fixes the problem before I apply it :)

Sorry I used '=3D' instead of '=3D=3D' and that worked.  I figured the '=3D=
=3D'
was just a typo.

Yours Tony

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO6d2BAAoJEEsCiJRY75GK/QgP/3FzHR7duM7jp6hH8xwwr3pI
dctYJTjnx3+cnjKBoCtqrVaobAswHcvzHuDv2vK/orcwL69LmGNYekBMSwY2HFG+
ZF+AyEN2wcDV2yPwsMLXm0LJuSuywMz5k/X8zGMub2vYyWaEWtjUOIpEeIu2Ys0f
NbXee9KZ0o8Na7plAR7zHlrBTBB9F9mbgd9JD5HCrI2WlsGmIsaqPC6kWy5LiPnd
eN/Df3kw4HLPWsWRqN9TKpSgVS0QGmRb03GGKI9TW6TpLmlkjCOSvRhkJ/BitZki
Kk4apNqL/YB7ODbHWeOgyFg4A7xV30rvDV34sqPUoOxUoeCKjEEw5VeoE1NOSkYX
YHJIdHNMJwgzCl4/i0XFnnAJwO5wu619J7sldb4CyarRpCtPeuWW/6RVC2ZCipv1
0pknFBXopiPYafbRZAJ13zJFVNV2peeW9lbd1d0YDkXYW7vcDpf13sC5z5ouUXPB
/+UzYs6WN/RUwCDwJHjLm1TvDYgmMZzoA0j/mkoYvwuLCnP9G3o6uSOPe4spVrYe
L9XtO+QxY/u4EQd3rpRlGVHdJMxWJcPC2UwYlUHsfaanwPtdTfubZtF39T33yC5E
GQoGsitZ++RhbWfO2gW8JarVMB+P5UcPmMmTaHuY7eJWu/ZPVoZiuidz/1OsWqgc
EQvuzn6eo3Jsnpc47TDd
=ymIJ
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
