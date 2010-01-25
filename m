Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id A24211007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 07:27:01 +1100 (EST)
Date: Mon, 25 Jan 2010 21:26:59 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH/RFC 2/2] 5200: improve i2c bus error recovery
To: Wolfgang Grandegger <wg@grandegger.com>
References: <1264191502.2224.2@antares> <4B5D4E56.3020902@grandegger.com>
In-Reply-To: <4B5D4E56.3020902@grandegger.com> (from wg@grandegger.com on
	Mon Jan 25 08:55:02 2010)
Message-Id: <1264451219.2315.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-7e95ZyvAvuyKn7/g9um7"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-7e95ZyvAvuyKn7/g9um7
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.01.10 08:55 schrieb(en) Wolfgang Grandegger:
> Albrecht Dre=DF wrote:
>> Make the I2C adapter timeout configurable through a Device Tree property=
 which gives the timeout in microseconds.
>=20
> My understanding is that software properties should not be defined via th=
e device tree. I think a sysfs entry is more appropriate.

Is the timeout really a /software/ property?  My feeling is that the timeou=
t basically depends upon the bus clock and the chips attached to the bus.  =
Therefore, it is linked closer to the composition of the board's hardware a=
s described in the device tree, than to any userland software.  Or am I tot=
ally wrong here?

Thanks, Albrecht.

--=-7e95ZyvAvuyKn7/g9um7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLXf6Tn/9unNAn/9ERAlHhAJ9Pf0hmP+CuHfgylTc41yaVS7NmOwCePcWv
YrIyOKdQJLoEwvBNn1PoeTY=
=Z3Rc
-----END PGP SIGNATURE-----

--=-7e95ZyvAvuyKn7/g9um7--
