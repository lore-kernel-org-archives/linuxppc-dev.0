Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 74F2667A73
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 00:17:29 +1000 (EST)
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20050328041119.GA30818@gate.ebshome.net>
References: <1111525951.2987.76.camel@ad.doubleclick.net>
	<20050328041119.GA30818@gate.ebshome.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gXAZSCSkpUNf/y043PTZ"
Date: Mon, 28 Mar 2005 09:17:24 -0500
Message-Id: <1112019444.7311.5.camel@ad.doubleclick.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Updated: CPM2 I2C (SDMA and BitBang)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-gXAZSCSkpUNf/y043PTZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-03-27 at 20:11 -0800, Eugene Surovegin wrote:
> Jason, another thought. Do we really need all this mess with separate=20
> algo and bus drivers?
>=20
> Could you make just a bus driver like we have for 4xx, Keywest and=20
> 85xx/52xx/MPC107? It's much cleaner and less confusing IMHO.


I made it separate algo/bus in case you had a PCI-card 85xx design
where:

	a) You booted the card with firmware
	b) The firmware made the card a PCI device with the CPM exposed
	   before you booted the kernel.
        c) The PCI host had to program an EEPROM on the CPM I2C bus
           for configuration to tell it where to get the kernel.

Admittedly, a little far out, but then you could make a
CPM-exposed-by-PCI I2C bus driver.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-gXAZSCSkpUNf/y043PTZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCSBH08/0vJ5szK6kRAuhEAKDYBaTZTKNDx4KxOzOvCRF5xxs7SACgoVMt
BAjvKGPhoLLFiDnFMlVJ3uI=
=iSkD
-----END PGP SIGNATURE-----

--=-gXAZSCSkpUNf/y043PTZ--
