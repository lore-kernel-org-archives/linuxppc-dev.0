Return-Path: <parabelboi@bopserverein.de>
Date: Mon, 15 Sep 2008 12:56:27 +0200
From: Christian Krafft <parabelboi@bopserverein.de>
To: ayoub_zaki@yahoo.fr
Subject: Re: PCI Post Boot scan
Message-ID: <20080915125627.5b3465ae@schleppi>
In-Reply-To: <428769.16820.qm@web26608.mail.ukl.yahoo.com>
References: <428769.16820.qm@web26608.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=_uKHiSdkqXjCu6E7EPLuxp";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_/=_uKHiSdkqXjCu6E7EPLuxp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ayoub,

On Mon, 15 Sep 2008 09:13:23 +0000 (GMT)
ayoub zaki <ayoub_zaki@yahoo.fr> wrote:

>=20
> Hi all,
>=20
> I'm working on a mpc8572ds based board from freescale.
>=20
> I have an onboard FPGA (PCI express) that I want to configure from the us=
erspace application with the corresponding "firmware".=20
>=20
> Only after a configuration that the FPGA shows its PCI nature.
>=20
> the problem is that linux has no way to detect the PCI device unless I re=
boot my board.
>=20
> fakephp wouldn't help scince my device is not configured at the boot time.
>=20
> Is there any way to do it so ?
>=20
> Is it possible to re-initialize the whole pci stack again ?

Does "lspci -M" do the trick ?

>=20
> Thanks for any kind help
>=20
> Ayoub Zaki
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


--=20
Cheers,
ck

--Sig_/=_uKHiSdkqXjCu6E7EPLuxp
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkjOP3sACgkQKGsoWZeX2LGW6QCbB4AL8FsqlplKmvEdL0NBAN3i
n7QAnjPq0xoyaD6rpxb7HKImNTc9+64K
=TrQm
-----END PGP SIGNATURE-----

--Sig_/=_uKHiSdkqXjCu6E7EPLuxp--
