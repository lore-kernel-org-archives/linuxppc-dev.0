Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Set dma_data correctly for direct_ops on pasemi
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080131064130.GA32344@lixom.net>
References: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
	<20080131064130.GA32344@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EPM7Uj0F70fBST1GlZel"
Date: Thu, 31 Jan 2008 23:38:16 +1100
Message-Id: <1201783096.4147.3.camel@concordia>
Mime-Version: 1.0
Cc: torvalds@linux-foundation.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-EPM7Uj0F70fBST1GlZel
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-01-31 at 00:41 -0600, Olof Johansson wrote:
> More late-caught fallout from the mainline merge. The patch:
>=20
> [POWERPC] Use archdata.dma_data in dma_direct_ops and add the offset
>=20
> "Now that all platforms using dma_direct_offset setup the
> archdata.dma_data correctly, ..."
>=20
> Nope -- the pasemi iommu setup code that disables translation on the
> DMA pci device didn't set dma_data correctly.
>=20
> The below patch is needed, please merge as soon as practical. Thanks!

Sorry about that.

I'm confused though, didn't your device come from alloc_pci_dev() which
kzalloc()s the pci_dev which contains the archdata which contains the
dma_data, ie. dma_data will already be 0?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-EPM7Uj0F70fBST1GlZel
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHocE4dSjSd0sB4dIRAkL3AKCz10lzJBXjgl/1NslBjwZGrLxvLwCgvYwH
Tq2X4ThcC6gkilXzd55eiUc=
=U+0H
-----END PGP SIGNATURE-----

--=-EPM7Uj0F70fBST1GlZel--
