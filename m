Date: Mon, 11 Dec 2000 01:46:41 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sound on an iBook?
Message-ID: <20001211014641.E18968@plato.local.lan>
References: <3A30F7C7.9650BDAD@wtal.de> <19341102094519.16548@192.168.1.2> <3A3490B9.ECA71E0D@wtal.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <3A3490B9.ECA71E0D@wtal.de>; from christof.petig@wtal.de on Mon, Dec 11, 2000 at 09:30:49AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2000 at 09:30:49AM +0100, Christof Petig wrote:
>=20
> Benjamin Herrenschmidt wrote:
>=20
> > >The link is dead, but
> > >http://www.micronas.com/products/documentation/consumer/dac3550a/index=
.php
> > >works for me well.
> > >
> > >Thank you very much for this information!
> >
> > Enclosed is Darwin's source for the audio and the I2C controller.
> >
> > You'll notice that they have 2 copies of the I2C code (one in the
> > audio driver itself and one separate). A quick look shows they are
> > identical (or very similar), but you should diff them to be sure.
> >
> > Ben.
> >
> >   ---------------------------------------------------------------------=
---
> >                   Name: Archive.sit
> >    Archive.sit    Type: Macintosh StuffIt Archive (application/x-stuffi=
t)
> >               Encoding: base64
>=20
> Thank you very much!
>=20
> Darwin is GPL, isn't it? So I can copy and modify the code for linux-kern=
el?

it most certainly is not, Darwin is under a non-free licence known as
the APSL.  it is not compatible with the GPL and may not be used in
any GPLed projects.  it is not free software.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature
Content-Disposition: inline


--sm4nu43k4a2Rpi4c--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
