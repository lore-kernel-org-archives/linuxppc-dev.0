Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6C4E9DDE30
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 09:53:09 +1000 (EST)
Date: Mon, 9 Jul 2007 09:52:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [patch 01/35] pasemi: rename platform
Message-Id: <20070709095259.0720669b.sfr@canb.auug.org.au>
In-Reply-To: <20070705170233.671358000@lixom.net>
References: <20070705170233.258351000@lixom.net>
	<20070705170233.671358000@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__9_Jul_2007_09_52_59_+1000_RV6VD+MIBon0DUI4"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__9_Jul_2007_09_52_59_+1000_RV6VD+MIBon0DUI4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Jul 2007 12:02:34 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> Rename the pasemi platform to "pasemi" to be in line with the platforms
> directory name.

This should also fix a problem further up in that file (in
pasemi_publish_devices) where we check for "machine_is(pasemi)".

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__9_Jul_2007_09_52_59_+1000_RV6VD+MIBon0DUI4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkXjoTgG2atn1QN8RAjupAKCD3c2nXtWwr/JbTxUlwpgjWMJuDwCdEvdd
jhc5C6xwuiYGbVq77SebZrA=
=B5iR
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Jul_2007_09_52_59_+1000_RV6VD+MIBon0DUI4--
