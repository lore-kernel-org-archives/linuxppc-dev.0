Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Sep 2007 15:39:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] usb: add device-tree-aware ehci driver
Message-ID: <20070918053945.GC30766@localhost.localdomain>
References: <20070917125039.GA29525@ru.mvista.com>
	<20070917125543.GA29584@ru.mvista.com>
	<20070917232809.1221acd9.sfr@canb.auug.org.au>
	<46EEC4AB.2030707@ru.mvista.com>
	<20070918142606.06477b04.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <20070918142606.06477b04.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2007 at 02:26:06PM +1000, Stephen Rothwell wrote:
> On Mon, 17 Sep 2007 22:17:15 +0400 Valentine Barshak <vbarshak@ru.mvista.=
com> wrote:
> >
> > Looks like we'll need a patch that replaces asm/prom.h and=20
> > asm/of_platform.h with linux/of.h and linux/of_platform.h
> > in other drivers.
>=20
> Yeah, but at the moment I am just stopping the infection spreading
> :-)

Patching the existing instances would probably help with that, since
it would mean less bad examples for people to copy.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG72ShaILKxv3ab8YRAh7LAJ9CCh+3IYTyL0lZx7MJNMbCmi9olQCggP+P
+JMQRdEECpGKJXVRGbwonJA=
=Rcxf
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
