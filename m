Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id 4A277DDED0
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 20:58:15 +1100 (EST)
Date: Sun, 25 Nov 2007 01:58:33 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: Access to PCI Expansion ROMs on PPC
Message-ID: <20071125095833.GA14557@curie-int.orbis-terrarum.net>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<jey7cmfyp9.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
In-Reply-To: <jey7cmfyp9.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2007 at 10:42:42AM +0100, Andreas Schwab wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
>=20
> > I put the card into an amd64 box, found the relevant 'rom' node ($ROM) =
under
> > /sys/device/pci*, and dumped it as follows:
> > # echo 1>$ROM
> Did you run it exactly like this?  Because this will echo exactly one
> newline to $ROM.  If you want to echo "1\n" you need to put a space
> between "1" and ">".
I did run the correct version, "echo 1 >$ROM", so that a "1\n" was
actually sent, and not a newline without a digit.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFHSUdJPpIsIjIzwiwRAo4gAKCiU5DCkUoDkgBkZnX5z8E3X4s5dACg4loS
U8iyyGVG8DrE1W968LQe+/A=
=Dep6
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
