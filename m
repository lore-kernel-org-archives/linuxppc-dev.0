Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/4 V6] MSI support on 83xx/85xx/86xx board
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <27CED929-FF61-42D3-A53C-C21B4980BF94@kernel.crashing.org>
References: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
	<20080523125929.GA8752@polina.dev.rtsoft.ru>
	<27CED929-FF61-42D3-A53C-C21B4980BF94@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-hHm2sIiJT8XSMUay6JL/"
Date: Sat, 24 May 2008 00:31:21 +1000
Message-Id: <1211553081.16348.0.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-hHm2sIiJT8XSMUay6JL/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-05-23 at 08:02 -0500, Kumar Gala wrote:
> On May 23, 2008, at 7:59 AM, Anton Vorontsov wrote:
>=20
> > On Fri, May 23, 2008 at 04:32:46PM +0800, Jason Jin wrote:
> >> This MSI driver can be used on 83xx/85xx/86xx board.
> >> In this driver, virtual interrupt host and chip were
> >> setup. There are 256 MSI interrupts in this host, Every 32
> >> MSI interrupts cascaded to one IPIC/MPIC interrupt.
> >> The chip was treated as edge sensitive and some necessary
> >> functions were setup for this chip.
> >>
> >> Before using the MSI interrupt, PCI/PCIE device need to
> >> ask for a MSI interrupt in the 256 MSI interrupts. A 256bit
> >> bitmap show which MSI interrupt was used, reserve bit in
> >> the bitmap can be used to force the device use some designate
> >> MSI interrupt in the 256 MSI interrupts. Sometimes this is useful
> >> for testing the all the MSI interrupts. The msi-available-ranges
> >> property in the dts file was used for this purpose.
> >>
> >> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> >> ---
> >
> > Hello Jason,
> >
> > Few comments below.
>=20
> Jason, I'll apply this version.  I expect some clean up based on Anton =20
> and Stephen's comments.

Version 4 or 5 of this patch had my ACK for the MSI bits FWIW.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-hHm2sIiJT8XSMUay6JL/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBINtU5dSjSd0sB4dIRAoEoAJ9XbmSF/9/gRafXPdsLfdPzAvIbgACeLgis
3P2xHz24g+QP/uP0Q2sYp8E=
=Sb5b
-----END PGP SIGNATURE-----

--=-hHm2sIiJT8XSMUay6JL/--
