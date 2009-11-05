Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id F2A19B7BA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 19:45:31 +1100 (EST)
Date: Thu, 5 Nov 2009 09:45:27 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 02/11] of/flattree: merge of_scan_flat_dt
Message-ID: <20091105084527.GB3478@pengutronix.de>
References: <20091105073728.10460.6061.stgit@angua>
	<20091105074527.10460.23877.stgit@angua>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
In-Reply-To: <20091105074527.10460.23877.stgit@angua>
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


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2009 at 12:45:35AM -0700, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze

Just minor fixes in nanodoc.

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 9faa9a5..7c3c13c 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -19,3 +19,68 @@ char *find_flat_dt_string(u32 offset)
>  	return ((char *)initial_boot_params) +
>  		initial_boot_params->off_dt_strings + offset;
>  }
> +
> +/**
> + * of_scan_flat_dt - scan flattend tree blob and call callback on each.

flattened

> + * @it: callback function
> + * @data: context data pointer
> + *
> + * This function is used to scan the flattened device-tree, it is
> + * used to extract the memory informations at boot before we can

I am not a native speaker, yet I have been taught there is no "informations=
".

> + * unflatten the tree
> + */

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrykKcACgkQD27XaX1/VRsLywCgs3Py1XfEtmhn0ZIIgaxE/5HJ
gw0An2Zx/QwbSHDpR+dyZfLr5OkTTpjt
=hGVU
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
