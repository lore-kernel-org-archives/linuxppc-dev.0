Date: Thu, 22 Feb 2001 06:49:14 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: do md5sums differ across architectures?
Message-ID: <20010222064913.N18058@plato.local.lan>
References: <200102221524.f1MFO2709134@ashley.ivey.uwo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xTKfHyrFnSV9DG3y"
In-Reply-To: <200102221524.f1MFO2709134@ashley.ivey.uwo.ca>; from khendricks@ivey.uwo.ca on Thu, Feb 22, 2001 at 10:24:01AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--xTKfHyrFnSV9DG3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2001 at 10:24:01AM -0500, Kevin B. Hendricks wrote:
>=20
> Hi,
>=20
> I ran md5sum on a big bz2 archive on my ppc linux box and then
> ftp'd it to my Sun Solaris 7 box at work.
>=20
> I checked it with md5sum on that machine and it differed.
>=20
> Okay I thought, a bad packet during upload.
>=20
> So I tried again, same result.
>=20
> I then passed back and forth (known good archives) and the md5sums
> were different.
>=20
> Okay, I thought maybe an endian issue but both Solaris Sparc and PPC
> Linux are big endian.
>=20
> Should these sums be different?

no, that would rather defeat the purpose of md5sum hashes.  one of
your md5sum programs is broken. =20

or perhaps you ftp'd in text mode instead of binary mode. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--xTKfHyrFnSV9DG3y
Content-Type: application/pgp-signature
Content-Disposition: inline


--xTKfHyrFnSV9DG3y--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
