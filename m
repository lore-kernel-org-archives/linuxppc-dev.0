Date: Thu, 11 May 2000 15:00:09 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
Message-ID: <20000511150009.D8481@cheops.usf.Uni-Osnabrueck.DE>
References: <20000511001504.11506.qmail@www0p.netaddress.usa.net> <Pine.LNX.4.10.10005111102470.4724-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
In-Reply-To: <Pine.LNX.4.10.10005111102470.4724-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Thu, May 11, 2000 at 11:07:39AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2000 at 11:07:39AM +0200, Michael Schmitz wrote:
> > > i've done some reasonably big compiles and run seti@home at the same =
time.
> > > however i've never kept at it for excessive periods of time...i'll le=
ave a
> > > kernel make looping tonight building off an nfs disk to the local disk
> > > and see if anything turns up by morning...
> >=20
> > I have left my lombard running for 4 days in a row which included sever=
al
> > sleeps. During this period I did a 6 hour stint playing with the develo=
pment
> > kernel code and did about 20 makes. No problems and this was after=20
> > I bumped it
> > up to 192. I could try building GRASS just to empirical though.
>=20
> Seems there's more people successfully running >64M in their Lombard here
> than it first seemed. Someone pointed to the kernel problem corner, so
> what kernel versions were these success stories run on?=20

Yes, we have to gather more data. Than then we have to seperate
the problems and search for similiarties and differences in the=20
machines.

There seems to be a significant number of people having this hard freeze
problem with Lombards. Here is my preliminary list, if I counted
correctly:

	Hard Freezes occuring:

Tim Wojtulewicz		Pismo 	128 MB
Bernhard Reiter		Lombard 128,192   2.2.14, 2.2.15pre19
Gabriel Ricard	    	Lombard 192 MB   + other problems
Mario Scarpa	        hard freeze as described?  64 MB + other problems


	Running fine:

jeramy b smith		lombard	192 MB
chris mccraw		lombard 128 MB 		2.2.12 thru 2.2.15pre20



As I have no idea on how to compare the stress tests, I can only say
that in 95% of all my test cases I can trigger a hard freeze within three
runs of:
	rpm -ba gnomehack.spec
(You can get my src.rpm from: ftp://intevation.de/users/bernhard/)

There was one day, when I could run it five times but still a hard
freeze later.


So we should gather more data on how to recreate the bug and then
ask more people to try to trigger it. As you can see from my preliminary
tests, there is no obvious pattern. Maybe we should also check the
different lombard models, if there are any. (At least I have a german
keyboard, e.g.)


Oh and more details from my part:
My RAM test from MacOS was completed fine, reporting no errors.
Adding the mem=3D64M option to the bootup (I am using bootx, could that
make a difference too?) seems to make the system more stable so far.

Jeramy, Chris: can you tell us which kernel and bootprocess you are using?
	Are you sure that linux uses all the memory?
	Can you build gnomehack three times?


	Bernhard
--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkartkACgkQh9ag3dpKERZ3fQCgre0Y4r3WpwJS3lpH+kMLDUz1
EskAoJxkde7r1InspyJDZeRy9ydCDvyz
=hNFJ
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
