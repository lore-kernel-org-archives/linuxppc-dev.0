Date: Mon, 24 Apr 2000 12:52:28 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial driver problem (modem Lombard)
Message-ID: <20000424125228.A15804@cheops.usf.Uni-Osnabrueck.DE>
References: <20000422123747.B8503@cheops.usf.Uni-Osnabrueck.DE> <3901D09B.4B25722F@pop.agri.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
In-Reply-To: <3901D09B.4B25722F@pop.agri.ch>; from toa@pop.agri.ch on Sat, Apr 22, 2000 at 06:17:37PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 22, 2000 at 06:17:37PM +0200, Andreas Tobler wrote:
> Bernhard Reiter wrote:

> > There is a difference in modem device behaviour
> > between 2.2.15pre3(coming with LinuxPPC2000) and 2.2.15pre19(after
> > Paul M's stable tree, build myself using his .config).
> >=20
> Depends on how you got the 2.2.15p19, I had some difficulties due to the
> fact that I was too fast. Paul did a backport of ppp-2.4.x to 2.2.x and
> I rsynced it with the auvz --delete option; In the wrong moment!!!. But
> it wasn't meant for 2.2.x.
>=20
> So only a clean download helped me. (not all the stuff, only with the -u
> disabled (update =3D=3D looks for date))

I used a clean download.

> Now I can report a clean, more or less, well ppp operation.
As I wrote, it always works on the first try.
It sometimes fials on the second and following tries with 2.2.15pre19.
It always works with the 2.2.15pre3 which does not have ir support build
in.=20


If wvdialconf scans the ir port ttyS1 on 2.2.15pre19, die machine bombs.

> > wvdail cannot open /dev/ttyS0 twice with 2.2.51pre19.
> > After I ctrl-ced wvdial to interrupt the network connection
> > I get an I/O error when I try to open it again.
>=20
> Do you have the module option in char/devices/serial on? (dumb serial dev=
ice)

Not that I know of. I admit that I have to learn a bit more about
kernel configuration to be sure, though.

> > Running wvdialconf it started scanning ttyS1 and
> > then jumped into the system monitor:
>=20
> Don't know about a lombard, but a wallstreet has 4 tty's 0,1,2,3
> (serial/printer =3D0, IRDA =3D1, modem =3D2; which is not present in my c=
ase;
> third =3D 3, the third is unused, I think the lombard has only one SCC so
> you can change the SERIAL_DEV_OFFSET to 2 iso 4.

ttyS0 is the modem under Lombard,
ttyS1 the IR port.

Most interestingly right now I cannot reproduce the I/O error.
So it works, most of the time. I hate this kind of errors.
So a hardware problem is still possible with this machine.

> > ps: Please carbon copy relevant replies to me.
> CC? or reply?
Usually people will reply to the list, I guess. I just wanted to say=20
that I am not subscribed, so It need to get a copy of posts which
are interesting.

--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkEJ2oACgkQh9ag3dpKERYHjACgnPrtKUwuhRPNMHA7tB4/Yz6f
zMUAoMVGjsZ5smC2l1/NTnoT9CIND6uP
=tky4
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
