Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/4] Enable MSI on Powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <1159386365.5542.115.camel@goblue>
References: <20060818081331.E6F7267B5D@ozlabs.org>
	<1159386365.5542.115.camel@goblue>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-hC2wLZrqhcMHzSaBeLIx"
Date: Thu, 28 Sep 2006 16:07:20 +1000
Message-Id: <1159423641.12398.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-hC2wLZrqhcMHzSaBeLIx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-27 at 14:46 -0500, Jake Moilanen wrote:
> On Fri, 2006-08-18 at 18:13 +1000, Michael Ellerman wrote:
> > Allow PCI_MSI to build on POWERPC.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >=20
> >  drivers/pci/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Index: git/drivers/pci/Kconfig
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- git.orig/drivers/pci/Kconfig
> > +++ git/drivers/pci/Kconfig
> > @@ -4,7 +4,7 @@
> >  config PCI_MSI
> >  	bool "Message Signaled Interrupts (MSI and MSI-X)"
> >  	depends on PCI
> > -	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
> > +	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64 || POWERPC
>=20
> Shouldn't this be PPC?

Maybe. If we use PPC then MSI will get built for arch/ppc as well which
won't work - so I think we should have a POWERPC symbol, I sent that as
a separate patch a while back but it seems to have hit the floor.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-hC2wLZrqhcMHzSaBeLIx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFG2aYdSjSd0sB4dIRAkHNAKCgOJJXwqVwoHYtmfrtnNPMLamXUACgpdY+
Tm9BYyvTVPKoWX2KR7xxIhM=
=Qzte
-----END PGP SIGNATURE-----

--=-hC2wLZrqhcMHzSaBeLIx--
