Date: Sun, 4 Feb 2001 05:49:55 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: incomplete asm-ppc/errno.h in 2.4.1 kernel.
Message-ID: <20010204054955.F6907@plato.local.lan>
References: <3A7D719C.7A0104C4@chello.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vj77qGokqwYdeLil"
In-Reply-To: <3A7D719C.7A0104C4@chello.nl>; from b.stolk@chello.nl on Sun, Feb 04, 2001 at 04:13:32PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--vj77qGokqwYdeLil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 04, 2001 at 04:13:32PM +0100, b.stolk wrote:
>=20
> Hi there,
>=20
>=20
> I'm trying to build 2.4.1 with reiserfs on my Motorola PowerStack II.

don't bother, reiserfs does not work on either 64 bit or big endian
archechures.  (basically anything but x86)

> But: EHASHCOLLISION seems to be missing from include/asm-ppc/errno.h
> It's present in asm-alpha and asm-i386
>=20
> Anyone working on reiserfs support for ppc at the moment?
>=20

jeffm of suse is working on it, he has it to where any attempt to
write to a reiserfs causes an immediate kernel panic. =20

see http://penguinppc.org/~jeffm/  for status updates on this. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--vj77qGokqwYdeLil
Content-Type: application/pgp-signature
Content-Disposition: inline


--vj77qGokqwYdeLil--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
