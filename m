Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B259F1A1931
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 08:20:22 +1100 (AEDT)
Date: Wed, 13 Jan 2016 22:20:08 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 frowand.list@gmail.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 panto@antoniou-consulting.com, bhelgaas@google.com,
 robherring2@gmail.com, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v7,49/50] drivers/of: Export OF changeset functions
Message-ID: <20160113212008.GC3881@katana>
References: <1446642770-4681-50-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160113135426.GA29030@katana>
 <1452719886.8203.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
In-Reply-To: <1452719886.8203.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2016 at 08:18:06AM +1100, Michael Ellerman wrote:
> On Wed, 2016-01-13 at 14:54 +0100, Wolfram Sang wrote:
> > On Thu, Nov 05, 2015 at 12:12:49AM +1100, Gavin Shan wrote:
> > > The PowerNV PCI hotplug driver is going to use the OF changeset
> > > to manage the changed device sub-tree. This exports those OF
> > > changeset functions for that.
> > >=20
> > > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > > Acked-by: Rob Herring <robh@kernel.org>
> >=20
> > I needed something like this, too [1] and rebased my series on top of
> > this patch. So:
> >=20
> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> OK. This series is kind of in limbo, it might hit 4.6, but it might not. =
So if
> you need this patch before then you should probably pull it in to your se=
ries,
> or ask Rob to merge it pre-emptively.

Yup, this is what I had in mind, too.

Thanks,

   Wolfram


--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWlr+IAAoJEBQN5MwUoCm2CuwP/0+rRmIuLdyefG6ryBWXzONA
/NEpjuUz+zugwMm+7K9Z6znKKqowMtYLZrLRbJhMlMta3bc5IZLgvz/sIIb/rRGS
JI9uD19Gpxga1obMDCTxmrzPzZD68iC03i1W85PQ7F6+bzsl3Y8gAfNYF1Mirjhm
Gy7aHfC5CkRqsCPDNHYp3c2bff7cFSyCpH8zHDytieSYU5q2wuekmpVbz4bb+D4E
TJT93/bNhjHfBoxZ/5F8O9+LYI4xb6d+wFzBY0mkdiGXWJh4UecwyeDgdWVrsivc
LpV25ASSxAFC0tsxUUoFXcsX/bGitbAUMCP3TtZ6OF0nFPIRPpFREcBHHAF62uMZ
L20z50/j1bY6t/5UFN8CNWHdHRLvBhWr+aiAIWwSmHsdkFK57L1DGaxtyGXUeuxx
kf3p76sSx8ri0lZkJ8sDHPJQEyY6W+TH4/uAiZiYo+DcWsCgQpGvzJiK7kpKV1Y2
rDgZJmOcsqkxgZJKgrlBxmtEHbsC4SrIDHGSRsFGdd4SMddeyQKkLyd4fdId22Ma
JM8kfm8RTXzktG8+BWh336Pg2vWgZrSBzj908pebls9kk70vhkHRJV6PyzfIMcvz
wtx6w1NfRu5GfiL5F/xL7Z4Zrxh7NQOnvqGQ7MDz3GfYNmBMG/mbWk8mYkyrgxp4
kSPyoNmmgEsqEJMUI1Ak
=0neK
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
