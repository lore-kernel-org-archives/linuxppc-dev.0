Date: Mon, 16 Apr 2001 03:46:25 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot params
Message-ID: <20010416034625.I2127@plato.local.lan>
References: <20010416113811.AC0762F083@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ry5joXArVtMDNz0J"
In-Reply-To: <20010416113811.AC0762F083@apollo.valhalla.net>; from iain@sandoe.co.uk on Mon, Apr 16, 2001 at 12:38:17PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Ry5joXArVtMDNz0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2001 at 12:38:17PM +0100, Iain Sandoe wrote:
>=20
> > Ethan Benson wrote:
> >> the kernel HFS driver is unreliable.=20
>=20
> Hmmm.  What do you mean?  I use it a lot (without problems AFAICT) - is
> there something I should know?

apparently people get occasional filesystem corruption when copying
larger files around.  its always been rather shady since nobody really
gives a damn about it.  which is why something as important as the
kernels should not live on HFS.  and bootloaders should live on a
never mounted tiny HFS partition managed by hfsutils or preferably
ybin. =20

it comes up on irc here and there. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--Ry5joXArVtMDNz0J
Content-Type: application/pgp-signature
Content-Disposition: inline


--Ry5joXArVtMDNz0J--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
