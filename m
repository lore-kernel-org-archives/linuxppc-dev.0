Date: Mon, 16 Apr 2001 04:05:53 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot params
Message-ID: <20010416040553.J2127@plato.local.lan>
References: <20010416115854.9A1722F09A@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/fbSefH2M6fEkVFW"
In-Reply-To: <20010416115854.9A1722F09A@apollo.valhalla.net>; from iain@sandoe.co.uk on Mon, Apr 16, 2001 at 12:59:03PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--/fbSefH2M6fEkVFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2001 at 12:59:03PM +0100, Iain Sandoe wrote:
>=20
> > which is why something as important as the
> > kernels should not live on HFS.
>=20
> OW machines don't have the choice.

yes they do, its called quik. =20

but for bootx it is still advisable to use hfsutils or only mount the
exchange partition rather then the real macos boot partition.
(exchange partitions used in a `/tmp' like capacity would not pose a
big deal to filesystem corruption)

> Yes, but I've not seen a report for months - the last IIRC were for 2.3.xx
> kernels ...

jeramy was mentioning some reports recently. =20

in any event are you saying the hfs driver is even resembling being
close to bug free?=20

didn't think so.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--/fbSefH2M6fEkVFW
Content-Type: application/pgp-signature
Content-Disposition: inline


--/fbSefH2M6fEkVFW--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
