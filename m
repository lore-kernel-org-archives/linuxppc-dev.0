Date: Fri, 10 Nov 2000 23:51:07 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Steven Hanley <sjh@wibble.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: success sort of with 2.2.10
Message-ID: <20001110235107.X4577@plato.local.lan>
References: <20001111190841.A8799@wibble.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ed2sj0fx90rgoibw"
In-Reply-To: <20001111190841.A8799@wibble.net>; from sjh@svana.org on Sat, Nov 11, 2000 at 07:08:41PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ed2sj0fx90rgoibw
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2000 at 07:08:41PM +1100, Steven Hanley wrote:
>=20
> All
>=20
> well 2.2.10 will get past the blank screen on my 7220, 2.2.18pre18 and
> 2.2.17 (came with debian) both dont.

well that rules out quik breakage at least.  progress! ;-)

> Anyway once I have found a way to make the thing get past this point in t=
he
> kernel booting, I will have to start going through the kernels from 2.2.10
> up and see which do and dont work. Now for that I need some way to get the
> different revisions. Are there any places other than bitkeeper that will =
let
> me do this? like a cvs tree? Paulus' rsync I dont think will let me get
> anything but the latest version that he has up there.

one thing i just remembered, did you compile 2.2.17 withOUT
CONFIG_BOOTX_TEXT  ?  BootXText screws up quik booting on some
machines apparently.   turning it off has made quik boot properly for
others. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--ed2sj0fx90rgoibw
Content-Type: application/pgp-signature


--ed2sj0fx90rgoibw--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
