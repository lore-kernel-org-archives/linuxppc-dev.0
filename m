Date: Sun, 28 May 2000 06:12:24 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_dmaproc - YaBoot
Message-ID: <20000528061224.I29071@plato.local.lan>
References: <200005261837.UAA00662@piglet.grunz.lu> <Pine.OSF.4.02.10005281508190.24780-100000@ax1305.physik.uni-marburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6pllAmZw5nNZD8Lv"
In-Reply-To: <Pine.OSF.4.02.10005281508190.24780-100000@ax1305.physik.uni-marburg.de>; from Henning.Loeser@Physik.Uni-Marburg.DE on Sun, May 28, 2000 at 03:20:30PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--6pllAmZw5nNZD8Lv
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2000 at 03:20:30PM +0200, Henning Loeser wrote:

> What I found seems to have been related to not using yaboot. As I have a
> 'old 7500' with MacOS8.1 I thought BootX would be just fine. But maybe
> not. Can I use yaboot on my machine? The WebPages are not very clear on
> that part. BenH's site states that yaboot is onbly for 'NewWorld' macs,
> but Eric's FAQ states that yaboot is for 'NewWorld' macs, but users of
> earlier machines should consider switching if they encounter odd problems
> ...

yaboot will not work on oldworld macs, you need to use quik instead.

> Well I do encounter strange Problems ...

seems typical of bootx lately...

> So should I go through the hassel of installing yaboot?

no because it would be a waste of time since it won't work ;-)  you
should go to the hassle of installing quik instead. (hint use debian
quik it actually works)

before anyone starts bitching about how quik is so horrible to setup,
let me say this, yaboot would be no different, they are both OF boot
loaders the only difference is yaboot is essentially a second stage
loader only, quik has a first stage loader which eliminates the need
for a bootstrap partition.  The problems people have with quik is the
following:

most [oldworld] macs don't have OF video drivers, this makes
interfacing with OF someone annoying.

oldworld macs have `the BrokenFirmware from hell' not even MS has made
anything as broken as this firmware ;-)

both of these problems exist just as well with yaboot as they do with
quik.   the only reason yaboot is less painful on newworld is due to
the one-quarter-way usable OF, and the OF video driver.=20

it might be possible to make yaboot work on an oldworld, but why? all
you would end up with is quik second stage. (which is basically all
yaboot is, quik second stage with bits of silo and other assorted
stuff to work on newworlds)

anyway my point is if you want OF booting on an oldworld you want
quik, not yaboot.=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--6pllAmZw5nNZD8Lv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkxKUgACgkQJKx7GixEevwClgCeIw6LcxRh4MWoPMba1SXbiTcR
FTAAnioLJQyI5vSZWY6fEljnxSBhqa7F
=9x0/
-----END PGP SIGNATURE-----

--6pllAmZw5nNZD8Lv--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
