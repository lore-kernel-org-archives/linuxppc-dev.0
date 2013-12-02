Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A4052C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 22:32:40 +1100 (EST)
Date: Mon, 2 Dec 2013 11:32:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Gerhard Sittig <gsi@denx.de>
Message-ID: <20131202113229.GO27568@sirena.org.uk>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-9-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="suYNV1AwziNMnBoj"
In-Reply-To: <1385851897-23475-9-git-send-email-gsi@denx.de>
Subject: Re: [PATCH v6 08/17] spi: mpc512x: adjust to OF based clock lookup
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 linux-spi@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--suYNV1AwziNMnBoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2013 at 11:51:28PM +0100, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'
>=20
> acquire and release the 'ipg' clock item for register access as well

Acked-by: Mark Brown <broonie@linaro.org.

--suYNV1AwziNMnBoj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnG/KAAoJELSic+t+oim90nUP/3RMo9UlKayd7EWIvI5yIs2G
Vrfvt3BEEJRukxtaP8W87yUKZ7bXc5dDCHMhDx1AFhvsQKmEYBM4M6pK863u3BOh
nN9QVTZSuQ1TO4G4J6tKu1lVnxtENp/0mxhdL48332NYZ5pgvn/UTr12m987mnH3
kYLPohvsmJu3xwwAQGoZ7cRrasb71tidv8Uo2I6xWuEJTCty89czv8M733XIlgib
DrMZaQ2cO3C0V5vLVrRGrUVzGJoBlOt+oMtUqqdUubb97VQ7W5B8kmp8LeJXBfE8
txNVqZADxK7df2BqsVg6SMAIzYCs08v7k8tdp+w5bIVYpZ6+ZgMIZzGmdHTqUuKS
hAFQmfGyoUVIy+Lse4yVxSTN8OVH5B0T7iI5CP8uG7/sHrQTz9tOUKo2CBLbhCey
MD8s7dW7YKpo6qjIsHZvMm1JUEUz8+4+QZ5BRvSxb57g1mzM7e5Yy4/HgcLS8yDx
2d+I629dfCv15pviYqXpBbZt7qBERqLmz9cwAbZVGoCVrXpP7jLtz7JiTu/oqmZV
deeoVSnBobomZ6wQOLW6sfm1/uuQvjByqwNQsOXEuAsay6tiEK8NdklumgIzoRqM
xdtEuTBUGlti/yfXUi7234Tq8+Xm0iwKzQQyEDqw5F9NmuX+Qk/9NoBs9w+SjR9Y
uoE/E+zZEcjP5y6WmETr
=fNEB
-----END PGP SIGNATURE-----

--suYNV1AwziNMnBoj--
