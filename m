Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1873679E2
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 20:42:47 +1100 (EST)
Subject: Re: [PATCH] PowerMac11,2 i2c-bus@0 duplicate dev-tree workaround
From: Johannes Berg <johannes@sipsolutions.net>
To: michael@ellerman.id.au
In-Reply-To: <1143783444.28005.10.camel@localhost.localdomain>
References: <1143631816.9481.5.camel@localhost>
	<1143700119.23392.27.camel@localhost.localdomain>
	<1143758297.5388.12.camel@localhost>
	<1143783444.28005.10.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CsIcRoA1baZ8wBmG4JkU"
Date: Fri, 31 Mar 2006 11:42:37 +0200
Message-Id: <1143798157.5388.21.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CsIcRoA1baZ8wBmG4JkU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-31 at 16:37 +1100, Michael Ellerman wrote:

> OK, that sounds a little complicated. I'm just worried about having lots
> workarounds in the unflattening code, the code's hard enough to read as
> it is.=20

Yeah that's a good argument.

> I think it's preferable to do the workarounds in the code that
> needs the workaround, that way they're isolated in certain parts of the
> code rather than all in the unflattening.

I'd really prefer to have these nodes vanish from the complete node
chain so we don't have the workarounds cluttering up the rather high
levels with machine dependent code. I'll find a better place to put it.

johannes

--=-CsIcRoA1baZ8wBmG4JkU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCz5iqVg1VMiehFYAQIXkRAAopILK0rN1YTX1KB3j3qjRV1HLoGRey8T
qYn4YTBDoG5oIWJ8ErT1NaQ3w1RvQy3IPswebaZedcZIASCCynO8YDn6YlUyI+XI
rh4N0711XiHGhWPlfYDg6rCZX2s1cqMiXJ73B4ynZSNJmKhuTzVAwrjRPWq1QyKu
9m4esNZzRZetz9iV3AS3LlXhEZOu5cM8sXeaC/3fH12EHSZLF0egvsdl85iIscjr
eoE5kJjvpDq6xOmLCVRrNkPlTsEBt3DzIm2wHCs6NN2sSECqLUHTd1qUoN+ofHaZ
Xac0Lct8morQ074kB/WEAFM7PBeTNav3rYVu3vHs20rylupFfSxydLIrDXuAndrk
5+cYWkv0VruaiP4Z2g2/ntva6MmZ9bpV/CoVjvxIn+riQpDDQpZj7lWMsKP214J4
VzklYlSAkalK6lYVdYvl8h0JFvmFIO6cpoZqyXVlEBCMyOZBfI3LJVctcfXfljBZ
VruUz6/2sHZaj5nt8H2AxqFNVCrBpZFhyoZIF0zunN2r5e6OLaq54V/oMWAogmyr
UPDD3TP8CEa4jKvNrfZ/LDPrXmc+NNaDiRCpkFJZGByaGp8LREhX1qv0pZCut6oj
DyYb8HBz1gCZsXxKaDztcc7VtmUqNsHO4I+wzSJBD4WCxOudIm0vyFmqJCtL/3rK
xFoi78NnFt8=
=oKVF
-----END PGP SIGNATURE-----

--=-CsIcRoA1baZ8wBmG4JkU--
