Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F2FA1DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 17:24:05 +1100 (EST)
Date: Thu, 29 Nov 2007 17:23:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH] Increase the upper bound on NR_CPUS.
Message-Id: <20071129172359.e4d700a4.sfr@canb.auug.org.au>
In-Reply-To: <20071129041603.GM24243@bakeyournoodle.com>
References: <20071129041603.GM24243@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__29_Nov_2007_17_23_59_+1100_WIsYGY6MpVZH9H2b"
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__29_Nov_2007_17_23_59_+1100_WIsYGY6MpVZH9H2b
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony, :-)

On Thu, 29 Nov 2007 15:16:03 +1100 tony@bakeyournoodle.com (Tony Breeds) wr=
ote:
>
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

NAK ... you need to change the static initialisation of the paca
structures to match ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__29_Nov_2007_17_23_59_+1100_WIsYGY6MpVZH9H2b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTlsDTgG2atn1QN8RAv80AJ9EERBPP4guZofCkcJ7xC4UT3QiUwCgiobH
t+JTIzezbEdoBUf1XEOUxLE=
=s4Mr
-----END PGP SIGNATURE-----

--Signature=_Thu__29_Nov_2007_17_23_59_+1100_WIsYGY6MpVZH9H2b--
