Date: Thu, 9 Nov 2000 07:38:14 -0900
From: Ethan Benson <erbenson@alaska.net>
To: jcarr@mail.linuxppc.org
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Example miboot on new world rom problem
Message-ID: <20001109073814.A4577@plato.local.lan>
References: <19341004061114.22300@192.168.1.2> <Pine.LNX.4.21.0011090829230.1582-100000@jcarr.linuxppc.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <Pine.LNX.4.21.0011090829230.1582-100000@jcarr.linuxppc.org>; from jcarr@mail.linuxppc.org on Thu, Nov 09, 2000 at 08:57:21AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2000 at 08:57:21AM -0600, jcarr@mail.linuxppc.org wrote:
>=20
> Some new ibook I think. I get the same behavior on the iMac DV. Startup
> disk doesn't change the boot-device value on there. Instead, it loads the

thats insane, probably a bug in apple's startup disk control panel...

> first TBXI file from the first HFS partition it finds. Then the MacOS ROM
> finds out that "LinuxPPC Boot" is the name of the partition to boot and
> then continues...
>=20
> Thus miboot is loaded on a new world rom machine.
>=20
> This is the reason I think either:
>=20
> 1) yaboot needs the code from pmac_support.c (aka SetPRAMBoot )
>=20
> 2) We'll have to write a new startup disk control panel( like system disk)

or 3)  setup the correct type of bootstrap for the current type of
machine.  then you don't have any of this nonsense. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature


--BOKacYhQ+x31HxR3--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
