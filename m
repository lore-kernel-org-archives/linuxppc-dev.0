Date: Wed, 26 Apr 2000 14:15:12 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: Andreas Tobler <toa@pop.agri.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial driver problem (modem Lombard)
Message-ID: <20000426141512.I2544@cheops.usf.Uni-Osnabrueck.DE>
References: <20000422123747.B8503@cheops.usf.Uni-Osnabrueck.DE> <3901D09B.4B25722F@pop.agri.ch> <20000424125228.A15804@cheops.usf.Uni-Osnabrueck.DE> <39043F06.CDED1B99@pop.agri.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
In-Reply-To: <39043F06.CDED1B99@pop.agri.ch>; from toa@pop.agri.ch on Mon, Apr 24, 2000 at 02:33:13PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2000 at 02:33:13PM +0200, Andreas Tobler wrote:
> Bernhard Reiter wrote:
> > =20
> > > Now I can report a clean, more or less, well ppp operation.
> > As I wrote, it always works on the first try.
> > It sometimes fials on the second and following tries with 2.2.15pre19.
> > It always works with the 2.2.15pre3 which does not have ir support build
> > in.
>=20
> I'm not sure, is it possible to disable IR in the kernel build? worth a t=
ry.

Probably.

> > If wvdialconf scans the ir port ttyS1 on 2.2.15pre19, die machine bombs.
> have you tried with something other than wvdial? (which I don't know), I
> use netcfg.

Wvdialconf scans all devices and tries to detect a modem.
For that reason it writes normal modem commands to the device.
So when scanning the ir port in my case, it should not detect a=20
modem, because there is none.=20

I just like to report the bug that the machine bombs with the
2.2.15pre19 kernel when wvdial writes the nonsense to the IR port. =20
A machine should never bomb.

My ppp runs fine with the configured modemport, apart from a couple
of occasion where I could only use it once.

I guess the next step of debuggin would be to try to use the IR for
something useful.
	Bernhard
	=20

--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkG3c4ACgkQh9ag3dpKERYt6QCghPnwof+F7ID0vOYJLzv0nu4M
IsUAn1C/6rXo9bQ/O8CK9VSINbhFAT3x
=co3s
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
