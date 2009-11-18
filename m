Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2FF021007D4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 21:41:54 +1100 (EST)
Date: Wed, 18 Nov 2009 11:41:47 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/4] Merge OF dynamic patches
Message-ID: <20091118104147.GD5166@pengutronix.de>
References: <4B030FC2.9070401@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
In-Reply-To: <4B030FC2.9070401@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2009 at 03:04:02PM -0600, Nathan Fontenot wrote:
> This set of patches merges the common dynamic device tree
> updating routines of_attach_node() and of_detach_node() to
> drivers/of/of_dynamic.c.
>
> Built and tested on powerpc, I have no access to build/test
> this on microblaze.

They look good, but I can't test them as they don't apply to test-devicetre=
e.
On which commit are they based?

It would be nice if you could also add a diffstat to every patch, this makes
reviewing 'move-around'-patches a bit easier.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksDz2sACgkQD27XaX1/VRtfAwCfbiHN6MiWlxdNLenJo8k9NNHu
P6cAoL7CzP6k83NcxfKGoh9XH0Qavq4i
=b7kS
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
