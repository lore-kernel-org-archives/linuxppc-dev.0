Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id DDC11DE8FF
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 01:21:03 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Flash on LocalBus @ MPC8343
Date: Fri, 11 Apr 2008 17:20:54 +0200
References: <47FF802B.5020708@matrix-vision.de>
In-Reply-To: <47FF802B.5020708@matrix-vision.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1562682.AkC8xHgeqR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804111720.57095.laurentp@cse-semaphore.com>
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1562682.AkC8xHgeqR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 11 April 2008 17:13, Andre Schwarz wrote:
> Hi all,
>=20
> I've been trying hard to make the mtd-partitions available via device=20
> tree on my MPC8343 local bus.
> No success so far ...
>=20
> Everything works fine on my MPC5200B based system - flash layout=20
> definition is quite simple ....
>=20
> To me it looks like there's a problem regarding the local bus in general.
>=20
> Am I missing a "compatible" or anything else ? "reg" or "ranges" ?
>=20
> The other boards use static map files or provide partition over command=20
> line args .... so suitable dts available.
>=20
> Flash is 8MB size in 16-Bit configuration and should reside on=20
> 0xFF800000 at cs0.
>=20
>=20
> Any hints ?
>=20
>=20
> regards,
> Andre Schwarz
> Matrix Vision
>=20
>=20
> dts syntax :
>=20
> <snip>
>=20
>         localbus@e0005000 {
>                 #address-cells =3D <2>;
>                 #size-cells =3D <1>;
>                 compatible =3D "fsl,mpc8343-localbus", "fsl,pq2pro-localb=
us";
>=20
>                 ranges =3D <0x0 0x0 0xff800000 0x00800000>;
>=20
>                 flash@0,0 {
>                         compatible =3D "amd,s29gl64", "cfi-flash";
>                         reg =3D <0 0 800000>;

reg should be <0 0 0x800000>.

>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         bank-width =3D <2>;
>                         device-width =3D <2>;
>=20
>                         ppcboot_env@0 {
>                                 reg =3D <0x0 0x2000>;
>                         };

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1562682.AkC8xHgeqR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH/4HZ8y9gWxC9vpcRAlosAKCq+HRwdpGJ5WJC0HoBp8HVRrorIwCgsA3X
NqnndaZeZJQoW2KK8N1IFLQ=
=eQpM
-----END PGP SIGNATURE-----

--nextPart1562682.AkC8xHgeqR--
