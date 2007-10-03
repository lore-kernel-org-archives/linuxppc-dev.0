Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 983C9DDE02
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 18:12:33 +1000 (EST)
Date: Wed, 3 Oct 2007 18:12:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
Message-Id: <20071003181215.e8942228.sfr@canb.auug.org.au>
In-Reply-To: <20071003171551.7184d83b.sfr@canb.auug.org.au>
References: <18179.13902.936820.573996@cargo.ozlabs.ibm.com>
	<20071003171551.7184d83b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__3_Oct_2007_18_12_15_+1000_O=z_T_D0DWXRqztW"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__3_Oct_2007_18_12_15_+1000_O=z_T_D0DWXRqztW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Oct 2007 17:15:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Would you also consider:
>=20
> [POWERPC] Prepare to remove of_platform_driver name
> (http://patchwork.ozlabs.org/linuxppc/patch?id=3D13667)

Also:

[PATCH 07/11] [POWERPC] iSeries: missing newline in printk
(http://patchwork.ozlabs.org/linuxppc/patch?id=3D13661)
and
[PATCH 10/11] [POWERPC] Clean up vio.h
(http://patchwork.ozlabs.org/linuxppc/patch?id=3D13664)

don't actually interact with the rest of the series.

I rebuilt {ppc64,pseries,iseries}_defconfig with just the above three
patches on top of the current for-2.6.24 tree to be sure.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__3_Oct_2007_18_12_15_+1000_O=z_T_D0DWXRqztW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHA07kTgG2atn1QN8RAseCAJ9iqIV94E/zF6kCliPnWMmXcne9IwCfbSqQ
bMg39S8KeJ9TZ+4cku6yNk4=
=/Xjf
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Oct_2007_18_12_15_+1000_O=z_T_D0DWXRqztW--
