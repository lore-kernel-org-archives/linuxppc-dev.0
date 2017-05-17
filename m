Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSYBY2NNVzDqb6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 22:13:41 +1000 (AEST)
Date: Wed, 17 May 2017 14:06:13 +0200
From: Pavel Machek <pavel@denx.de>
To: sr@denx.de, jwboyer@linux.vnet.ibm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] powerpc/sequoia: fix NAND partitions not to overlap
Message-ID: <20170517120613.GA583@amd>
References: <20170402100535.GA18340@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <20170402100535.GA18340@amd>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2017-04-02 12:05:36, Pavel Machek wrote:
> Fix overlapping NAND partitions.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Ping? Two partitions at same place are bad news...
									Pavel

> diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/se=
quoia.dts
> index b1d3292..e41b88a 100644
> --- a/arch/powerpc/boot/dts/sequoia.dts
> +++ b/arch/powerpc/boot/dts/sequoia.dts
> @@ -229,7 +229,7 @@
>  						};
>  						partition@84000 {
>  							label =3D "user";
> -							reg =3D <0x00000000 0x01f7c000>;
> +							reg =3D <0x00084000 0x01f7c000>;
>  						};
>  					};
>  				};
>=20
>=20
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkcPLUACgkQMOfwapXb+vLv4gCgtb3eCfVmWElFyIPyhlyCSvlz
/s4AoJ5Hm55rRg5oZVQyfgmrv/FsssHp
=BR+o
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
