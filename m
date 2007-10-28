Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] ehea: add kexec support
From: Michael Ellerman <michael@ellerman.id.au>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200710261437.29117.ossthema@de.ibm.com>
References: <200710261437.29117.ossthema@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ATWZuS5Lm8sq4ZfYPXwY"
Date: Mon, 29 Oct 2007 09:32:17 +1100
Message-Id: <1193610737.9637.1.camel@concordia>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ATWZuS5Lm8sq4ZfYPXwY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2007-10-26 at 14:37 +0200, Jan-Bernd Themann wrote:
> eHEA resources that are allocated via H_CALLs have a unique identifier ea=
ch.
> These identifiers are necessary to free the resources. A reboot notifier
> is used to free all eHEA resources before the indentifiers get lost, i.e
> before kexec starts a new kernel.
>=20
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
>=20

How do you plan to support kdump?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ATWZuS5Lm8sq4ZfYPXwY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHJQ3xdSjSd0sB4dIRAhOeAKCEzaMVIPKt463BuNy0opmESDSpJQCgv7Li
NHEDkMAat1QUPzdxUk9Zu7A=
=PlOw
-----END PGP SIGNATURE-----

--=-ATWZuS5Lm8sq4ZfYPXwY--
