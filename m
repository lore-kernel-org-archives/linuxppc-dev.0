Date: Sat, 16 Dec 2000 23:18:52 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: problem compiling test12
Message-ID: <20001216231852.E17742@plato.local.lan>
References: <3A3C0420.ADEF0E3C@denise.shiny.it> <19341110154330.5294@192.168.1.10>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
In-Reply-To: <19341110154330.5294@192.168.1.10>; from bh40@calva.net on Sat, Dec 16, 2000 at 11:11:46PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2000 at 11:11:46PM +0100, Benjamin Herrenschmidt wrote:
>=20
> >I can't compile 2.4.0-test12:
> >
> >arch/ppc/mm/mm.o: In function `map_page':
> >arch/ppc/mm/mm.o(.text+0xd90): undefined reference to `set_pgdir'
>=20
> Are you using the bk source trees ? The main linus tree is far outdated
> on PPC specific parts, unfortunately, Linus has ignored almost all PPC
> patches sent for the patch few monthes (despite sending them the way he
> wants, in small parts, etc...)
>=20
> I remember Linus once saying he didn't care about PPC...

maybe you should conspire with Alan Cox to have him submit patches,
Alan seems to be more friendly towards merging powerpc code into the
2.2 trees anyway...

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature
Content-Disposition: inline


--HeFlAV5LIbMFYYuh--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
