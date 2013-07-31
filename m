Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id B325A2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 17:52:42 +1000 (EST)
Date: Wed, 31 Jul 2013 17:52:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc: Add smp_generic_cpu_bootable
Message-Id: <20130731175233.013066d0c473b1138774dc15@canb.auug.org.au>
In-Reply-To: <1375140785-9782-1-git-send-email-afleming@freescale.com>
References: <1375140785-9782-1-git-send-email-afleming@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__31_Jul_2013_17_52_33_+1000_aL+AS1RhiTxoSb1/"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__31_Jul_2013_17_52_33_+1000_aL+AS1RhiTxoSb1/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, 29 Jul 2013 18:33:04 -0500 Andy Fleming <afleming@freescale.com> wr=
ote:
>
> +EXPORT_SYMBOL(smp_generic_cpu_bootable);

I am pretty sure that none of the places you are going to use this can be
built as modules, so remove this EXPORT_SYMBOL, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__31_Jul_2013_17_52_33_+1000_aL+AS1RhiTxoSb1/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR+MJFAAoJEECxmPOUX5FE1RoP/1fiu1W/PNdldFZeWtFWLT/v
tHLJo7pCsXdKXn17QdsCKeEsoGrtvL2eKh9bkRnMnPdhB0IKMrcPLuEa8WiIsUiB
vVsraW8UTunjoscHPpAyorW1s/I7Pjcrcqv3neZLCffkWaxKDavnQ4rKw7Y+ONIn
sP9nU5CorYsNr80I3V8i5pmqFlHfGJOjxteCJB8xpPz/Lg9ATT8SGXHMPDufUNvh
Gl/HXUJo9WwJmyudMzKfF3zMjcBZD4rqZf8Hqv/Q2O20ILBgji5dKys70wspJJzN
IMdvG8TvmOMmke1sWnYJv7IIrlaQriRqpE/KdOoIUv9v0BN0hL0I0VOM28zcefJq
uB0GJ5H8f/lhqgvLBmWXE4rCCFFL2o9b9b0pWSOtLrSlpnejijbZ49/hN7320F5f
Ec8EhhlUTVSMawhhGU67Im7knZK2MThj/704RiEU3ufM6nhOm1clE5rgtflvt2rw
Sk7P4bsoIRKVpfwJNF6/QuayY3YNWK8hhnN5CCYWL9eIxilzHFDV1/Ee/ez3n12i
yrQS71KyqXZdix5h2Sr8Ustca7BoNGvPFQdckMsrhS692AzWG0AvIzDbNqzAQ9kN
vOUK3X0iY0VWXAq9teFP4PVRPpLbpDOc7c6j/FbO+bX5bvjO9GfOkeNqazxNYcWX
X/261BIBfYFyowR5FOKq
=ji2B
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Jul_2013_17_52_33_+1000_aL+AS1RhiTxoSb1/--
