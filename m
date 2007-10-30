Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] ehea: add kexec support
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Raisch <RAISCH@de.ibm.com>
In-Reply-To: <OF79E7ACE7.5D0488CE-ONC1257384.002E58C0-C1257384.002F8561@de.ibm.com>
References: <200710261437.29117.ossthema@de.ibm.com>
	<1193610737.9637.1.camel@concordia>
	<OF79E7ACE7.5D0488CE-ONC1257384.002E58C0-C1257384.002F8561@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CmVz5gAZys5+6MeUC5iC"
Date: Wed, 31 Oct 2007 09:50:36 +1100
Message-Id: <1193784636.32504.4.camel@concordia>
Mime-Version: 1.0
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, ossthema@linux.vnet.ibm.com,
	Jeff Garzik <jeff@garzik.org>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <MEDER@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CmVz5gAZys5+6MeUC5iC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Tue, 2007-10-30 at 09:39 +0100, Christoph Raisch wrote:
>=20
> Michael Ellerman <michael@ellerman.id.au> wrote on 28.10.2007 23:32:17:
> >
> >
> > How do you plan to support kdump?
> >
>=20
> When kexec is fully supported kdump should work out of the box
> as for any other ethernet card (if you load the right eth driver).
> There's nothing specific to kdump you have to handle in
> ethernet device drivers.
> Hope I didn't miss anything here...

Perhaps. When we kdump the kernel does not call the reboot notifiers, so
the code Jan-Bernd just added won't get called. So the eHEA resources
won't be freed. When the kdump kernel tries to load the eHEA driver what
will happen?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-CmVz5gAZys5+6MeUC5iC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHJ7U8dSjSd0sB4dIRAubzAJ0eYG2bv6FPefxuha0m4gn4vgoEwACgpplu
F2/eB6tWnkcAvOlO8I750yI=
=9k6M
-----END PGP SIGNATURE-----

--=-CmVz5gAZys5+6MeUC5iC--
