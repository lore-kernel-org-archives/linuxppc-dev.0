Date: Sun, 14 May 2000 04:02:36 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Even André <even@lynweb.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: downgrading harddrive from 9.0
Message-ID: <20000514040236.H12729@plato.local.lan>
References: <B53E4B2D.30F%even@lynweb.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTtJ75FAzB1T2CN6"
In-Reply-To: <B53E4B2D.30F%even@lynweb.net>; from even@lynweb.net on Sun, May 14, 2000 at 03:05:00PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--gTtJ75FAzB1T2CN6
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, May 14, 2000 at 03:05:00PM +0200, Even Andr=E9 wrote:
>=20
> Hi, I've bought me one of those PowerBook Pismo G3's 400...
> When I try to boot into linux I get a "hda: lost interrupt" signal,
>  the same as I had on my PowerMac G3 B/W...
> This is a problem with the Mac OS 9 hd driver, right?
>=20
> The problem is that I can't get the PowerBook to boot from my Mac OS 8.5 =
CD
> to downgrade my hd drivers to the 8.5 drivers.
> I've now updated my hd drivers with the fwb HDToolkit 4.0 app, this doesn=
't
> seem to work either.
> Shouldn't this work?
>=20
> The bottom line is, can anyone tell me how to downgrade my hd drivers (if
> this is what causing the problem), since the Drive Setup from OS 8.5 can't
> be loaded
> on my PowerBook w/ OS 9.04 ??

you don't.=20

the proper solution is "Don't use BootX, use yaboot"

you need to use yaboot, deal with it.

you can find a yaboot-faq on my web page (see my .sig)
(~/erbenson/doc/yaboot-faq.html) and a GNU/Linux based yaboot
installation utility. ybin (which also includes yaboot docs).

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--gTtJ75FAzB1T2CN6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkeldwACgkQJKx7GixEevxBwQCeLmAjw/G/bcqmPhBqZvebyyoa
q/gAniowDNkHFaNFS7aECJ6QrFWt0rTz
=uVsa
-----END PGP SIGNATURE-----

--gTtJ75FAzB1T2CN6--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
