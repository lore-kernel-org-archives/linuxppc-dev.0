Date: Sat, 20 May 2000 18:17:06 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Matt McLean <keys@yikes.com>
Cc: Debian-PowerPC <debian-powerpc@lists.debian.org>,
        Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Paul's 2.2.15 does not boot a 7200
Message-ID: <20000520181706.F7243@plato.local.lan>
References: <20000520002947.A6452@plato.local.lan> <Pine.BSF.4.21.0005201535200.59827-100000@nerf.yikes.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
In-Reply-To: <Pine.BSF.4.21.0005201535200.59827-100000@nerf.yikes.com>; from keys@yikes.com on Sat, May 20, 2000 at 03:38:37PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, May 20, 2000 at 03:38:37PM -0700, Matt McLean wrote:
> Hey,
>=20
> That sounds like it's not recognizing your onboard video...

would that cause the kernel to fail to boot entirely?  the machine
never becomes pingable, sshable, nor does it dial ppp at boot like it
usually does. =20

> Be sure you have CONFIG_FB, CONFIG_FB_OF, and CONFIG_FB_PLATINUM set to
> yes in your kernel config...

yup, my .config is available on request, i did not want to spam the
list with such a large file.  besides i tried using paul's config
included in his rsync tree as well, it failed too, the exact same way...

> Otherwise, do you have a strange CPU upgrade?  Did earlier versions of
> Paul's kernel work on your machine?

no and yes, the machine is perfectly stock except for having more
ram.  and paul's 2.2.14 works on it (that is what it is running now)

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjknRyIACgkQJKx7GixEevyM0gCdGlwDzEDEJhBARaJVoHm3sh3m
zE8AnRj4xXPVhM7ek8rrCqc0699u5V5y
=4UZ3
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
