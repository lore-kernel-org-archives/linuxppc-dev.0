Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0F3F5DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 17:24:39 +1100 (EST)
Date: Sat, 29 Dec 2007 17:24:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/4] USB: add Cypress c67x00 OTG controller core driver
Message-Id: <20071229172426.4488046b.sfr@canb.auug.org.au>
In-Reply-To: <20071228235236.16003.44475.stgit@trillian.secretlab.ca>
References: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
	<20071228235236.16003.44475.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__29_Dec_2007_17_24_26_+1100_kF4psHD=129==+fk"
Cc: akpm@osdl.org, dbrownell@users.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, stern@rowland.harvard.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__29_Dec_2007_17_24_26_+1100_kF4psHD=129==+fk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

Just one nit ...

On Fri, 28 Dec 2007 16:52:36 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +static int __devinit c67x00_drv_probe(struct platform_device *pdev)
> +{
> +	struct c67x00_device *c67x00;
> +	struct c67x00_platform_data *pdata;
> +	struct resource *res, *res2;
> +	int ret, i;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	res2 =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res2)
> +		return -ENODEV;
> +
> +	pdata =3D (struct c67x00_platform_data*)pdev->dev.platform_data;

This cast is unnecessary.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__29_Dec_2007_17_24_26_+1100_kF4psHD=129==+fk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHdeghTgG2atn1QN8RAp2MAKCPYuqWm4uPI+ijLr1ENLRk0G/IvgCffLrK
p10+rYn3uJp1wvfV4YeC0P4=
=/tSF
-----END PGP SIGNATURE-----

--Signature=_Sat__29_Dec_2007_17_24_26_+1100_kF4psHD=129==+fk--
