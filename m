Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id ACE29B7BEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 05:26:01 +1000 (EST)
Date: Thu, 22 Apr 2010 21:25:49 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: Boot hang when setting console=none with MPC5200B custom board
To: Sylvain Lamontagne <sylvain.lamontagne@novariant.com>
In-Reply-To: <1271962721.12334.34.camel@slamon-laptop.novariant.com> (from
	sylvain.lamontagne@novariant.com on Thu Apr 22 20:58:41 2010)
Message-Id: <1271964357.1672.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-T9kcwHYOQ/nHCppU3SkA"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-T9kcwHYOQ/nHCppU3SkA
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sylvain:

Am 22.04.10 20:58 schrieb(en) Sylvain Lamontagne:
[snip]
> 1. Is it possible ?

Yes!  I tried this with several kernel versions (currently 2.6.33), using t=
he option 'console=3Dtty0'.  Works just fine...

> 2. Do you have any idea how it can be achieve ?

Hmmm, iirc, I also saw the effect you have.  I *think* the solution was to =
ensure that all /dev/* files were created manually in the jffs image, not b=
y running mdev (if you use busybox).  But I might be wrong here, sorry.  Be=
ing at home, I don't have access to the device, but I can re-check tomorrow=
.

> 3. Do you know a bug in 2.6.29.2 that could prevent this to work ?

Not sure if I used *exactly* that version w/o serial console, but (iirc) 2.=
6.28.something, and then many different up to .33 - they all work!

Best, Albrecht.

--=-T9kcwHYOQ/nHCppU3SkA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBL0KLFn/9unNAn/9ERAjzQAJ4xMPZIwc1mC3l24FbD58XUbrkHuACgopHn
7rHJkG7u19434OW9OAOTKSg=
=6vrS
-----END PGP SIGNATURE-----

--=-T9kcwHYOQ/nHCppU3SkA--
