Date: Sun, 4 Feb 2001 15:12:18 -0900
From: Ethan Benson <erbenson@alaska.net>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: incomplete asm-ppc/errno.h in 2.4.1 kernel.
Message-ID: <20010204151218.N6907@plato.local.lan>
References: <3A7DE3C0.53F6D938@chello.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FJOUHINv8uyEJFmS"
In-Reply-To: <3A7DE3C0.53F6D938@chello.nl>; from b.stolk@chello.nl on Mon, Feb 05, 2001 at 12:20:32AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--FJOUHINv8uyEJFmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2001 at 12:20:32AM +0100, b.stolk wrote:
> >don't bother, reiserfs does not work on either 64 bit or big endian
> >archechures.  (basically anything but x86)
>=20
> >From the FAQ at namesys I understand that ReiserFS works on alpha.
> Alpha is as 64bit as it gets....
> Not only has is sizeof(void *)=3D=3D8, but even sizeof(bool) is 8 :-)
> (imagine that: using 64 bits to store a single one!)

ok maybe they fixed the 64 bit issues, it used to not even be 64bit
clean.  but it most certainly not endian clean, it only works on little
endian archetectures which rules out sparc and powerpc. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--FJOUHINv8uyEJFmS
Content-Type: application/pgp-signature
Content-Disposition: inline


--FJOUHINv8uyEJFmS--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
