Date: Tue, 25 Apr 2000 18:26:37 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: Mario Scarpa <m.scarpa@mondonet.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze
Message-ID: <20000425182637.K22219@cheops.usf.Uni-Osnabrueck.DE>
References: <20000424161311.23404.qmail@web1705.mail.yahoo.com> <20000424191708.C16557@cheops.usf.Uni-Osnabrueck.DE> <39058B20.7D29A470@mondonet.net> <20000425144459.E22219@cheops.usf.Uni-Osnabrueck.DE> <390594BF.97FD809E@mondonet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
In-Reply-To: <390594BF.97FD809E@mondonet.net>; from m.scarpa@mondonet.net on Tue, Apr 25, 2000 at 02:51:11PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2000 at 02:51:11PM +0200, Mario Scarpa wrote:
> Bernhard Reiter wrote:

> > So do you think, just not pluggin in the usb mouse might help?
> > This should be easy to test. Or do I need a kernel without usb support?
>=20
> When I was not using my USB mouse I neither had the support
> into the kernel; if it's not a great deal to you we can try
> not to use (and not to enable) USB for a while and see what
> happens. Due to the type of crash (total hang) it's quite
> difficult to me to find out what's wrong so having a hint about
> the possible cause could tighten the search a lot.

The error still comes when I boot up without any mouse plugged in.

Next I will disable USB support in the kernel an build a fresh one.
(Any hint on how to do this systematically,=20
I am not very experienced with configuring kernels.)

	Bernhard

--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkFxzwACgkQh9ag3dpKERZAHgCfe24mTfHeshgitl0tu1mJMWBU
X9oAoI4ZjCK7K5RRdOeGVxV1rNUlV53z
=HwcE
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
