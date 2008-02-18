Return-Path: <Valdis.Kletnieks@vt.edu>
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu
	[128.173.14.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "foo-bar-baz.cc.vt.edu",
	Issuer "foo-bar-baz.cc.vt.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7E1EBDDF30
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 05:31:22 +1100 (EST)
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
	endianness
In-Reply-To: Your message of "Mon, 18 Feb 2008 08:18:47 +0100."
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
From: Valdis.Kletnieks@vt.edu
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1203355811_2991P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 18 Feb 2008 12:30:11 -0500
Message-ID: <19805.1203355811@turing-police.cc.vt.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--==_Exmh_1203355811_2991P
Content-Type: text/plain; charset=us-ascii

On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
> I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
> Both resolve endianess at driver level. Actually, both handle it by setting special
> bits so the graphics chip itself reorder bytes to transform foreign endianess. 
> I understand that this patch is for chips which cannot reorder bytes by themselves.

Does anybody know of such a chip that's actually available in the wild?  Or are
we writing drivers for speculative possible chips?

--==_Exmh_1203355811_2991P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFHucCjcC3lWbTT17ARAs3WAJsF9CsHmgfsLvqldWPilbhoVFS5NACfTFrJ
i5E2PGuWzLogM8fqDx25xCo=
=be6Y
-----END PGP SIGNATURE-----

--==_Exmh_1203355811_2991P--
