Date: Wed, 26 Apr 2000 14:22:56 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: Mario Scarpa <m.scarpa@mondonet.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze
Message-ID: <20000426142256.J2544@cheops.usf.Uni-Osnabrueck.DE>
References: <20000424161311.23404.qmail@web1705.mail.yahoo.com> <20000424191708.C16557@cheops.usf.Uni-Osnabrueck.DE> <39058B20.7D29A470@mondonet.net> <20000425144459.E22219@cheops.usf.Uni-Osnabrueck.DE> <390594BF.97FD809E@mondonet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IR1Y5IvQhrKgS4e6"
In-Reply-To: <390594BF.97FD809E@mondonet.net>; from m.scarpa@mondonet.net on Tue, Apr 25, 2000 at 02:51:11PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--IR1Y5IvQhrKgS4e6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2000 at 02:51:11PM +0200, Mario Scarpa wrote:
> > > Same here. I would say that it all started when I bought
> > > my USB mouse and started using the USB bus: before I was
> > > using the trackpad and do not remember about similar locks.
> > > Just a hint.
> >=20
> > So do you think, just not pluggin in the usb mouse might help?
> > This should be easy to test. Or do I need a kernel without usb support?
>=20
> When I was not using my USB mouse I neither had the support
> into the kernel; if it's not a great deal to you we can try
> not to use (and not to enable) USB for a while and see what
> happens. Due to the type of crash (total hang) it's quite
> difficult to me to find out what's wrong so having a hint about
> the possible cause could tighten the search a lot.

Compiled kernel 2.2.15pre19 without usb support.
According to my first tests the system is more stable now.
I have not encountered a hard freeze yet, though running compiles which
usually trigger one for certain.

Test are continuing, though.

The first diagostic of the problem is, that it is a usb problem.
Even when no usb device is used. So who is the person we have to
report this bug to? Or is everybody relevant reading this list anyhow?
:-)
	Bernhard
--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--IR1Y5IvQhrKgS4e6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkG358ACgkQh9ag3dpKERYLDQCfS3IQLkHIuS2+d1fPVqcXrwP4
KTEAoI9mu6gGIitz8Usvc6wj3n1mIjV4
=1gce
-----END PGP SIGNATURE-----

--IR1Y5IvQhrKgS4e6--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
