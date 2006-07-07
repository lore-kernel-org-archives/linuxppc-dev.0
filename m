Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71E3D67B65
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 19:04:50 +1000 (EST)
Subject: Re: snd-aoa: g5 tas codec problems
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1152262585.9862.61.camel@localhost.localdomain>
References: <1152258426.9862.44.camel@localhost.localdomain>
	<1152262148.15068.30.camel@localhost>
	<1152262585.9862.61.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-X4uLAkE1svZ25UDpMUn+"
Date: Fri, 07 Jul 2006 11:04:33 +0200
Message-Id: <1152263073.15068.32.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-X4uLAkE1svZ25UDpMUn+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 18:56 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-07-07 at 10:49 +0200, Johannes Berg wrote:
> > On Fri, 2006-07-07 at 17:47 +1000, Benjamin Herrenschmidt wrote:
> > > Also, we should try
> > > (if not already the case) to cache our clock/i2s state so that
> > > subsequent prepare() don't try to change things that are already ok.=20
> >=20
> > I do that, the function reads the dws and sfr registers and exits early
> > if they match.
>=20
> Ok. Be careful that I've removed the initial init of TAS thinking we
> always get to clock restart to do it in prepare()... might need to be
> put back.

Oh yes, we do, wonder why it even worked then since most of the time
we'll be using whatever the firmware does (44.1KHz,16bit).

johannes

--=-X4uLAkE1svZ25UDpMUn+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4jnqVg1VMiehFYAQImshAAuyUx7qqQlQFFNL+FaS5soOZnS+zwairI
uM9SwPGiag9dzqjbYlTYh3IGtZB4jfzDynLGI+rj/seAK2T+3yxzc4Tqd0qdVGo9
k3ftZHEThY03sjbCSkhChp/Fsiba5+tSl8vIHwCf4Ylo722OIFfiObBEqrRKcLV6
ybXlTCkee1jNreYmIqji1rJntq5MtTEbIbf6eNPuNAmuDhz4WPTw7/OUUH7KvbLH
CShJTUdT47qdtoO/ZoLibWJ9QXkbeCe7ABW/gbCy71WY/hM3lZ0cUJwTpQaUZZuj
0hvLdojkap5fzdi3LjDrp+aREnXtRIdECZyAUwXKbMTstwSqzDMxzASXLDhiEGxb
2f0ht/4/wh/PkNmSEyOR3d3VAaktqYwCpzDxBvMwBrvMyyN8DFrtDNW1VK5m9sc8
IYFpLvTwzer1ZHryNZ3p5obOugJbyIZ75JbJBHVqsXHMnOHrCIU/MOrJQ/poPDNu
piZjR8pvIFch4ycyyJHHgnL46BvmC4sUbzBveKr/0XLQLYSHCYGqGG+sY2Jd+ye6
EwhVZhZ/z05DYe9YvbstNIZpT2NCK525/0rDDUu3NQfwDhN+H2cHlaIQvmg80Tj8
wU6neR+5u3KNVNKl8FCYE1R7qShrqEyzcbIPYh6GNIO6nas2apuFFmXUzFYJWo/I
9vrApP9Mues=
=iJqc
-----END PGP SIGNATURE-----

--=-X4uLAkE1svZ25UDpMUn+--
