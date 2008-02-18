Return-Path: <Valdis.Kletnieks@vt.edu>
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu
	[128.173.14.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "foo-bar-baz.cc.vt.edu",
	Issuer "foo-bar-baz.cc.vt.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E19C7DDE9F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 05:12:51 +1100 (EST)
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
In-Reply-To: Your message of "Mon, 18 Feb 2008 14:27:10 GMT."
	<12131.1203344830@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0802181500410.13406@vixen.sonytel.be>
	<47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
	<20080216103927.2a02352b@laptopd505.fenrus.org>
	<1203249003.6718.24.camel@concordia>
	<20080218135609.GD21080@cs181133002.pp.htv.fi>
	<12131.1203344830@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1203358266_2991P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 18 Feb 2008 13:11:06 -0500
Message-ID: <26571.1203358266@turing-police.cc.vt.edu>
Cc: Adrian Bunk <bunk@kernel.org>, Roel Kluin <12o3l@tiscali.nl>,
	lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
	linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	cbe-oss-dev@ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--==_Exmh_1203358266_2991P
Content-Type: text/plain; charset=us-ascii

On Mon, 18 Feb 2008 14:27:10 GMT, David Howells said:

> __builtin_expect() is useful on FRV where you _have_ to give each branch and
> conditional branch instruction a measure of probability whether the branch
> will be taken.

What does gcc do the 99.998% of the time we don't have likely/unlikely coded?

--==_Exmh_1203358266_2991P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFHuco6cC3lWbTT17ARAh+cAKD5ET97Gyef5yariQO4KkTKYSAucQCgomsw
NiqkKVG+zUxU2wMpR2NuZbk=
=ycYU
-----END PGP SIGNATURE-----

--==_Exmh_1203358266_2991P--
