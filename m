Date: Mon, 23 Apr 2001 23:14:25 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rsync access through NAT?
Message-ID: <20010423231425.C8585@plato.local.lan>
References: <Pine.LNX.4.33.0104171133410.17972-100000@ash.penguinppc.org> <200104240553.HAA01467@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
In-Reply-To: <200104240553.HAA01467@piglet.grunz.lu>; from mlan@cpu.lu on Tue, Apr 24, 2001 at 07:53:38AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2001 at 07:53:38AM +0200, Michel Lanners wrote:

> I have ECN compiled in all my 2.4 kernels. They are building right now
> without ECN.... We'll see.
>=20
> <a compile & reboot later>

there is a sysctl variable that disables this at runtime you know ;-)
i don't remember where it is offhand, sysctl -a | grep ecn or find
/proc -name '*ecn*' -print should find it. =20

> Yup, that seems to be the problem. rsync works again for me on
> penguinppc. So I guess that some device close to penguinppc.org doesn't
> support ECN.....

probably turning on ecn is more trouble then its worth right now,
unfortuanatly...=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature
Content-Disposition: inline


--z4+8/lEcDcG5Ke9S--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
