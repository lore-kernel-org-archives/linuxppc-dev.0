Date: Sun, 21 May 2000 04:26:44 -0800
From: Ethan Benson <erbenson@alaska.net>
To: jeramy b smith <ultrapenguin@netscape.net>
Cc: Debian-PowerPC <debian-powerpc@lists.debian.org>,
        Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pauls 2.2.15 does not boot a 7200
Message-ID: <20000521042643.J7243@plato.local.lan>
References: <20000521121729.8813.qmail@www0x.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
In-Reply-To: <20000521121729.8813.qmail@www0x.netaddress.usa.net>; from ultrapenguin@netscape.net on Sun, May 21, 2000 at 07:17:29AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2000 at 07:17:29AM -0500, jeramy b smith wrote:
> I rsynced up to 15 from pre20 and compiled the kernel. Boots just fine us=
ing
> bootx on the 7200 I stole from work on Friday.

as i have mentioned bootx is not an option, there is no macos (and no
space for it)

> Using the novideo option as well as video=3Dplatinumfb

ill try forcing the video to that so we can at least see if the kernel
is giving any hints as to why it fails to boot.

> I can try to OF boot this 7200 but I don't want to develop a migraine this
> weekend.

bah OF booting is not that hard ;-)

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkn1gMACgkQJKx7GixEevyPPACfUwHk73zzIDxEI7VZSFM9bpue
9SAAoJmKEtgCnjAXPl82KU7gNYRZiWWA
=o9zx
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
