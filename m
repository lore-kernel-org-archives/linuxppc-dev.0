Date: Mon, 15 May 2000 10:52:18 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
Message-ID: <20000515105218.C4202@cheops.usf.Uni-Osnabrueck.DE>
References: <20000511150009.D8481@cheops.usf.Uni-Osnabrueck.DE> <Pine.SUN.4.21.0005140159110.4879-100000@panix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
In-Reply-To: <Pine.SUN.4.21.0005140159110.4879-100000@panix.com>; from unit@panix.com on Sun, May 14, 2000 at 02:42:15AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

I had a couple of incidents of strange modem or serial port
behaviour. It went away for no aparend reason.
I am not sure if it is a related problem, though.

One of my friend suggested to check on the serial numbers and ask
apple if this was a line of production somehow special
(done with certain chips or on the same week or something.)

The People count, btw is up to  6:2.

Best bet: Try the mem=3D64M option, if hard freezes cannot be triggered
anymore you might have the same problem.


        Hard Freezes occuring:

Tim Wojtulewicz         Pismo   128 MB
Bernhard Reiter         Lombard 128,192   2.2.14, 2.2.15pre19
Gabriel Ricard          Lombard 192 MB   + other problems
mpas1@nospam.iol.it (Marco Pascucci)=20
			Lombard 192 MB	went away with "mem=3D64M"
Mario Scarpa            hard freeze as described?  64 MB + other problems
unit@panix.com		hard freeze as described? Walstreet 192 MB  ppp problem


        Running fine:

jeramy b smith          lombard 192 MB
chris mccraw            lombard 128 MB          2.2.12 thru 2.2.15pre20


	Bernhard



On Sun, May 14, 2000 at 02:42:15AM -0400, unit@panix.com wrote:
> it should also be noted that the wallstreet is suffering hard crashes
> also (at least i am) .. just to complicate the issue.
>=20
> My particular problem (which i had posted to the group a few weeks
> back) relates to ppp (though what exactly locks up the machine i have
> no idea).
>=20
> What happens is this:
>=20
> I am connected via ppp, my connection drops (which it is know to do
> reasonably regularly). I restart the connection (/sbin/ifup ppp0), if i
> tail -f */messages it goes through the whole connection procedure and
> then once the handshaking has taken place, everything locks.=20
> I've attempted to run pppd via console which works,
> but the moment i switch console, again everything locks w/ no possiblity
> of switching console. I've had this happen under these exact circumstances
> on 20+ occasions, so, at least in my case it is reproducable. This only
> happens after a modem hang-up, and i have yet to have one instance of
> restarting ppp without this happening.=20
>=20
> As far as compiling i have had no problems (mozilla being a recent 'large'
> compile that wen't w/out incident.

--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--bAmEntskrkuBymla
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkfusEACgkQh9ag3dpKERb+gwCfbgImcy2t0s+iwzi3MLa8V84L
uFkAoKJgEYYu1KGAaqUoNL2EBX8qmcfq
=2SSh
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
