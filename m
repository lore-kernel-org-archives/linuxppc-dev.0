Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EBD53DDE06
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 16:11:16 +1000 (EST)
Date: Tue, 6 May 2008 16:11:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bryan O'Donoghue <bodonoghue@codehermit.ie>
Subject: Re: [PATCH] Add support for Analogue & Micro ASP837E board
Message-Id: <20080506161110.02c2f974.sfr@canb.auug.org.au>
In-Reply-To: <20080506032813.19e2d07a@neuromancer.mindspace>
References: <20080506032813.19e2d07a@neuromancer.mindspace>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_May_2008_16_11_10_+1000_DuZ/+tEO+Vm7ra8b"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_May_2008_16_11_10_+1000_DuZ/+tEO+Vm7ra8b
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bryan,

On Tue, 6 May 2008 03:28:13 +0100 Bryan O'Donoghue <bodonoghue@codehermit.i=
e> wrote:
>
> +static void __init asp834x_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np =3D of_find_node_by_type(NULL, "ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);

You need an "of_node_put(np)" here to drop the reference gained in
"of_find_node_by_type".

> +static struct of_device_id asp8347_ids[] =3D {

Please make this __initdata.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_May_2008_16_11_10_+1000_DuZ/+tEO+Vm7ra8b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIH/aCTgG2atn1QN8RAntHAJ9QB0SVMTJU99RSBM1NsoBrVVqjtgCeLSHQ
zq6GwSdjVD5nnFneOvVIKIU=
=1oXH
-----END PGP SIGNATURE-----

--Signature=_Tue__6_May_2008_16_11_10_+1000_DuZ/+tEO+Vm7ra8b--
