Date: Thu, 6 Jul 2000 23:08:51 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org, Ethan Benson <erbenson@alaska.net>
Subject: Re: Multi-boot advice.
Message-ID: <20000706230850.T7162@plato.local.lan>
References: <200007070652.HAA20893@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LvvJQ0mOwKOuU4xd"
In-Reply-To: <200007070652.HAA20893@hyperion.valhalla.net>; from iain@sandoe.co.uk on Fri, Jul 07, 2000 at 07:52:10AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--LvvJQ0mOwKOuU4xd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2000 at 07:52:10AM +0100, Iain Sandoe wrote:
>=20
> On Fri, Jul 7, 2000 Ethan Benson wrote:
> > On Thu, Jul 06, 2000 at 09:38:38AM +0100, Iain Sandoe wrote:
> >> Yea Hey first to Apple Drive setup (which at least these days will all=
ow
> >> most stuff to be set up) - and then to pdisk - to check it out.
> >
> > just don't create any linux partitions with apples drive setup, it
> > won't work.  instead add up the sizes of all the planned linux
> > parittions and create a placeholder HFS partition with apple drive
> > setup, then delete it with pdisk and populate the freed space with the
> > linux and bootstrap partitions.
>=20
> This is interesting.  I've seen (several times) the comment that the Apple
> Drive Setup tool doesn't work for Linux.
>=20
> However, it certainly did for me (on the Lombard & on a 9600/233)... under
> what circumstances does it fail?

every time i tested it the following occured:

* drive setup crashed
* the partition tables were corrupt.

its just good policy to use the native fdisk to create an OS'es
partitions, on intel we must use DOS fdisk to create DOS/Win*
partitions and linux fdisk for linux partitions, same with OpenBSD,
FreeBSD etc.  powerpc is no different. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--LvvJQ0mOwKOuU4xd
Content-Type: application/pgp-signature


--LvvJQ0mOwKOuU4xd--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
