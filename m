Date: Tue, 17 Apr 2001 06:19:55 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot params
Message-ID: <20010417061955.C6381@plato.local.lan>
References: <20010417093736.4BEC72F001@apollo.valhalla.net> <200104171403.QAA00755@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
In-Reply-To: <200104171403.QAA00755@piglet.grunz.lu>; from mlan@cpu.lu on Tue, Apr 17, 2001 at 04:03:45PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2001 at 04:03:45PM +0200, Michel Lanners wrote:
>=20
> You sure your backup battery is OK? It's not completely dead, I think
> otherwise the box wouldn't boot; but you may test it anyhow.
>=20
> Also, you could add an nvsetenv script on shutdown as a workaround.

well on some machines the MacOSROM resets the nvram, so you must never
allow it to boot.  quik is generally best for people wanting to get
rid of the useless space wasting MacOS in these cases. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature
Content-Disposition: inline


--oTHb8nViIGeoXxdp--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
