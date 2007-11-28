Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8038BDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 11:41:11 +1100 (EST)
Date: Wed, 28 Nov 2007 11:41:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-Id: <20071128114104.3444b012.sfr@canb.auug.org.au>
In-Reply-To: <20071127153908.GB14183@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__28_Nov_2007_11_41_04_+1100_qYPJS7h_ChhjmA8a"
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__28_Nov_2007_11_41_04_+1100_qYPJS7h_ChhjmA8a
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Nov 2007 18:39:08 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +static int __devinit pata_of_platform_probe(struct of_device *ofdev,
> +					    const struct of_device_id *match)
> +{
> +	uint32_t *prop;

Make this "const uint32_t *prop" or (more kernel like) "const u32 *prop" ...

> +	prop =3D (uint32_t *)of_get_property(dn, "ioport-shift", NULL);

then you don't need this cast.  Anytime you use a cast to get rid of
"const", is probably a mistake.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__28_Nov_2007_11_41_04_+1100_qYPJS7h_ChhjmA8a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTLkkTgG2atn1QN8RApj4AJ98KRtWfLTiHUYvFnA017ECyqeX8gCgjhga
HIzwioNIVfMR0fm3OyAJiR4=
=0KEg
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Nov_2007_11_41_04_+1100_qYPJS7h_ChhjmA8a--
