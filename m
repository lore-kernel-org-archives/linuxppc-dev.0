Return-Path: <dedekind1@gmail.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id D18272C007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 19:15:59 +1000 (EST)
Message-ID: <1348650963.24309.38.camel@sauron.fi.intel.com>
Subject: Re: [PATCH] driver/mtd:IFC NAND:Initialise internal SRAM before any
 write
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 26 Sep 2012 12:16:03 +0300
In-Reply-To: <68738277-B1F2-4455-B8FD-67F2DD9E1310@kernel.crashing.org>
References: <1347526489-20186-1-git-send-email-prabhakar@freescale.com>
 <68738277-B1F2-4455-B8FD-67F2DD9E1310@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-FiVp+/BvaQsEbFRSnn2l"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org, Prabhakar Kushwaha <prabhakar@freescale.com>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-FiVp+/BvaQsEbFRSnn2l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-13 at 07:53 -0500, Kumar Gala wrote:
> > drivers/mtd/nand/fsl_ifc_nand.c |   56 ++++++++++++++++++++++++++++++++=
++++++-
> > 1 file changed, 55 insertions(+), 1 deletion(-)
>=20
> If MTD maintainers ack, I'm happy to pull this in via PPC tree.

Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

--=20
Best Regards,
Artem Bityutskiy

--=-FiVp+/BvaQsEbFRSnn2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQYsfTAAoJECmIfjd9wqK0zz8QAML/bhrKUFxuW3GQmHxD3C9M
vupzEOGj0xo3HsfqbfVqRMg1T6DYIbb46QIi/H8kfNFwQIjakFdhnpqY5uNdo4R9
K4Eci+evoeVAP3zuveCHQ8d3jiPPj3B7nodY9HgBZjGfgqXXrOwqhR97++btfkGp
EEXGq5RO1UJjiBxvrBxKeU5XEhiVbw+rB0r7xX/T50/0GI2GO90GlC8ueOptQXPj
p+HDGPmUOKUZQT/6dpqWG8+diC86dXEVJP+Wkxlh4E9Ia6uCi+qRk22HnXpt3oiE
BZDQF4eszcQ37Gm1GYVmvMdJ7WiAEx8N4Sxsqi8roPdd04WaWs1JS6rBV0VJUHTO
RxYIUGPz0rSxBBDbAnGYQzLX/NNdDd2tFux0+DwrQ2gDbA9zCR7nErcWuTfM5XYL
gG5Ph/SGa48M5ka+9Ln9DjHRGPAMDgzr3pkEFjlXaCGbhJA/VzEmLalnffXVLSPn
XU9Hj3JFqmo2FpgXcsKqENV4Xq1xpDr7FKVfKnllKOR0ipw1sYpxa9RZ0refkbOb
JwsXnaN12nI4zUwHop3TA/Xs0LvB6bmXyJnrJgHHJyy13tM8xKROFHH1Ty6xuIsH
ZwxXfl4kFufbVvRrLOjWvd3lsfdI+IIDhsxNrCCiKmPBsyXpPUIFFlqZoHMX9cyB
fWDw7o0I3phAHIpRnnzD
=5WP1
-----END PGP SIGNATURE-----

--=-FiVp+/BvaQsEbFRSnn2l--
