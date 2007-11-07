Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA039DDE29
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 02:04:52 +1100 (EST)
Subject: Re: 2.6.24-rc1-git15 Kernel build fails on powerpc - Unrecognized
	opcode: `dssall'
From: Johannes Berg <johannes@sipsolutions.net>
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1194428323.4055.3.camel@johannes.berg>
References: <47304343.2010709@linux.vnet.ibm.com>
	<661de9470711060246s3040f68drf0a6310aeec4e1e8@mail.gmail.com>
	<1194346486.4066.13.camel@johannes.berg>
	<20071106.031001.189578769.davem@davemloft.net>
	<47304FE5.2010309@linux.vnet.ibm.com>
	<47306E9C.4090202@linux.vnet.ibm.com>
	<20071106154439.GK5080@shadowen.org>
	<1194428323.4055.3.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-26Y8EXtSwRy74FzyOLmt"
Date: Wed, 07 Nov 2007 13:49:39 +0100
Message-Id: <1194439779.4470.5.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, sam@ravnborg.org,
	David Miller <davem@davemloft.net>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-26Y8EXtSwRy74FzyOLmt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Wed, 2007-11-07 at 10:38 +0100, Johannes Berg wrote:
>=20
> > So that sounds like a Kconfig problem then?  That HIBERATION requires
> > ALITIVEC and yet does not depend on it or set it.
>=20
> Yes. I'm guessing that it broke with Rafael's hibernation/suspend
> Kconfig changes but will take a look. I think it used to depend on
> powermac.

Hmm, no, it didn't. I don't feel confident enough that nobody cares
about this code to make these Kconfig changes for 2.6.24.

johannes

--=-26Y8EXtSwRy74FzyOLmt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzG0YaVg1VMiehFYAQLF3w/+NQFkyTeE8bwChy93sXbJCKIHipDktfSi
MXyZNjC1g36N+h/LFAd27uVv1ldkkHPqbQGdroZHstUjScsXJ/VoRRP9jq+bvYPM
Pzj5dVAY89BXy7r6iiCnE+tLEEmbEMrPtgGhx0uvujaU7m/CMulPnP3Gx4EGdWyi
gdL3bBzXawxm7JfYbPylHENl3JLfpbm1Cdd9+gUl5LFBCNIk0H4ZgLv7ytRn6yyG
GwwxcWdsMUA4p8C4uAO6FjiS8JXeLYz3epCExZu63vjbuloTMqk6FevG72sW+cqU
TNXkDZLLjiUjmxC+A0z1rVdKkjgo2pO2y3BQxtUuzEAxWMqsRDxKFtPiWE1x31L4
f8IGp/WBUmi7ITB2Fqy1OQyZ1WG4XsGwcQjwy4EoDSE9NYwN7ha5Y0Ik9bH7hil+
s1KWaMGyEC1enAeLpi/e62vZYwShUmmRKGdr6aRlgruulw2Uad5pOpjvcDGgtd+n
9SXMboBLmw5H4EWkC1K5Jc+6vMVYKqi2CqRs4OFR75lSUQA2KFRKBVqnkN00soSv
rhKXHGOxXc7nd/e/e3yxe2XXajywEq09e7L8LzxRSDDZi4xIQg3ie5UsEmT41o2P
M5sRdqgWConqYZjbq3kc/avJDyNoSO3yuOhtAWvdlW736YmaHG+EMop0kv42siCZ
wlEMOz/ITvg=
=ZYcs
-----END PGP SIGNATURE-----

--=-26Y8EXtSwRy74FzyOLmt--
