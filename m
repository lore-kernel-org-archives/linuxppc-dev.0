Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 3300EB7BA8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 19:49:55 +1100 (EST)
Date: Thu, 5 Nov 2009 09:49:45 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 05/11] of/flattree: merge of_get_flat_dt_prop
Message-ID: <20091105084945.GC3478@pengutronix.de>
References: <20091105073728.10460.6061.stgit@angua>
	<20091105074606.10460.23775.stgit@angua>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
In-Reply-To: <20091105074606.10460.23775.stgit@angua>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2009 at 12:46:13AM -0700, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

nanodoc comment again

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a6e869e..7a51343 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -100,3 +100,46 @@ unsigned long __init of_get_flat_dt_root(void)
>  	return _ALIGN(p + strlen((char *)p) + 1, 4);
>  }
> =20
> +/**
> + * of_get_flat_dt_prop - Given a node in the flat blob, return the prope=
rty pointer
> + *
> + * This  function can be used within scan_flattened_dt callback to get

double space

> + * access to properties
> + */

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrykakACgkQD27XaX1/VRviXwCgmd8x2wzO31elQKz+vb54m/fl
LdQAoMIpSqdRZ6QoqDQJON/9Rr7LZ07u
=pnJ0
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
