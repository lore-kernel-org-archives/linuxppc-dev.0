Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix warning in pci_64.c
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070515143042.987cba34.sfr@canb.auug.org.au>
References: <20070515041705.CCC00DDFC9@ozlabs.org>
	<20070515143042.987cba34.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BWS9iM9J9Xz70JXcNJkp"
Date: Tue, 15 May 2007 16:03:09 +1000
Message-Id: <1179208989.6905.1.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BWS9iM9J9Xz70JXcNJkp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-15 at 14:30 +1000, Stephen Rothwell wrote:
> On Tue, 15 May 2007 14:16:35 +1000 Benjamin Herrenschmidt <benh@kernel.cr=
ashing.org> wrote:
> >
> >  void pcibios_add_platform_entries(struct pci_dev *pdev)
> >  {
> > -	device_create_file(&pdev->dev, &dev_attr_devspec);
> > +	int rc =3D device_create_file(&pdev->dev, &dev_attr_devspec);
> > +	WARN_ON(rc !=3D 0);
>=20
> If we really don't care if the file is not created, then it is probably
> worth a comment as to why ...

Greg already has a patch from me to fix that.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-BWS9iM9J9Xz70JXcNJkp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGSU0ddSjSd0sB4dIRAmO5AJ9aVA3cM0wRgfevX+692KKrG39zrwCfUS76
b9vbOVSQq5b7k8EtNtGXqWI=
=g2wB
-----END PGP SIGNATURE-----

--=-BWS9iM9J9Xz70JXcNJkp--
