Return-Path: <marc.leeman@ieee.org>
Received: from scorpius.homelinux.org (213.219.172.5.adslpower.by.edpnet.be
	[213.219.172.5]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1507A67B3F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2005 18:15:24 +1000 (EST)
Date: Thu, 12 May 2005 09:47:51 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: majid khan khan <majidkhan14@rediffmail.com>
Message-ID: <20050512074751.GH21217@scorpius.homelinux.org>
References: <20050512064316.16591.qmail@webmail18.rediffmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibvzjYYg+QDzMCy1"
In-Reply-To: <20050512064316.16591.qmail@webmail18.rediffmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: how is flow in linux right from bootstrap program
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>    i am new to PowerPC arch , is anyone tell me what is the best way to k=
now

Off the top of my mind; ...

The only thing that you need to know IIRC is that the boot address is at
0xfff00000. I believe that's fixed. If your bootloader is placed there,
you can let it jump to whereever you want.

--=20
  greetz, marc
Harvey, kiss my medulla oblongata.
	Crichton - Infinite Possibilities - Daedalus Demands.shtml
scorpius 2.6.11 #1 Wed Mar 2 16:38:38 CET 2005 GNU/Linux

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgwonUQpj09NWLeERAtZQAKC8RukRglM7CvgbJuZf1Az4AKlAugCfUVcn
hyCJelz9t31SzRuDbOPMLys=
=L7Ab
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--
