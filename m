Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP0JQ6jCWzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 13:21:10 +1100 (AEDT)
Date: Thu, 16 Feb 2017 13:01:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, jallen@linux.vnet.ibm.com,
 sahilmehta17@gmail.com, mdroth@linux.vnet.ibm.com
Subject: Re: [PATCH v7 1/4] powerpc/pseries: dlpar_memory_readd_by_index()
 when MEMORY_HOTREMOVE not defined
Message-ID: <20170216020142.GN12369@umbus.fritz.box>
References: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20170215184518.11755.94323.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SgT04PEqo/+yUDw3"
In-Reply-To: <20170215184518.11755.94323.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SgT04PEqo/+yUDw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 01:45:22PM -0500, Nathan Fontenot wrote:
> Add a definition for dlpar_memory_readd_by_index() that returns
> -EOPNOTSUPP to correct a build error when the config option
> MEMORY_HOTREMOVE is not set.
>=20
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/power=
pc/platforms/pseries/hotplug-memory.c
> index 3381c20..f971ea0 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -629,6 +629,11 @@ static int dlpar_memory_remove_by_index(u32 drc_inde=
x, struct property *prop)
>  	return -EOPNOTSUPP;
>  }
> =20
> +static int dlpar_memory_readd_by_index(u32 drc_index, struct property *p=
rop)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> =20
>  static int dlpar_add_lmb(struct of_drconf_cell *lmb)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SgT04PEqo/+yUDw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYpQgEAAoJEGw4ysog2bOSGMcP/RVH+wvaNE5RKp6d4va3oYz6
G3+897xAGaVcnDqoyQz1PY9nYjfxxp5gjDedaJg5oLt3Z8aWOVDFM4wtCdj9C3ve
jkb5BgLZfWjvTCfBshHOa7Z82E+4gUXlQc4yq5OTJOK+dSB7uHcPQFqNKu4usu1l
rvwmVYcOUzEOvaalXeQtMq+m0TxmWTIEL+y0MobsBeDNmo10aRQJU3zu2DsYvmQv
dfBLczlsGgSnDIGqwAwy9SjbB/9gvYgm3TWQosUIFbOcBAORU6dBjaDRMwdWtO1S
uprXrILK/ZjJ+zvkE1ibkH4IoWYXCfvtkSlady89D5UQ0BvKD19FxeE9bI2yir+R
7xBGtbKTbpmRsGyz17w64khQEYTBW4Yr8KUmDx+mfHKu5/JvZQeU3iaWdM8rOUKv
U1RxoJkJmWwnO3C2PZKYw9e1Er0q6NxyI+PFAB/kU9pwBoreF9LFRO80vkVzBj+D
dMAHAvQZ1v0ARvbhokTIOsbsQEZMA0SJgWlKkKTl2cprWCo6G4JE2MEhBazBv4WA
Y8XKvATtNBhEa28Jt4rmdbwr+X7owcSVc845hqzwmctaHRXj4afvV2HvvNqvb+64
ZIQG3DrMLRY12FloId2NY4M4FXp9cwkNxiND3wScMoJuV5ekiC7rzT2nUzp472li
z/EQLRCxcniL3p2MuunP
=D0p8
-----END PGP SIGNATURE-----

--SgT04PEqo/+yUDw3--
