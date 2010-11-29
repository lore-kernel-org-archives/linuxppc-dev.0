Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Record vma->phys_addr in ioremap()
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1291006613.32570.288.camel@pasglop>
References: <e4aea657faf920a0d207e582724ccd7ef08487f1.1291004790.git.michael@ellerman.id.au>
	<1291006613.32570.288.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-XCmPg9ERQhXBfMBIEDVL"
Date: Mon, 29 Nov 2010 16:04:16 +1100
Message-ID: <1291007056.10110.60.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-XCmPg9ERQhXBfMBIEDVL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-11-29 at 15:56 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2010-11-29 at 15:26 +1100, Michael Ellerman wrote:
> > The vmalloc code can track the physical address of a vma, when the
> > vma is used for ioremap, if set it is displayed in /proc/vmallocinfo.
> >=20
> > Because get_vm_area_caller() doesn't know it's being called for
> > ioremap() it's up to the arch code to set the phys_addr. A bunch
> > of other arch's do this, I'm not sure why powerpc doesn't?
>=20
> Because I never noticed ? :-)

Yeah I figured. It seems to go back past 2.6.12 so who knows when it
went in, anyway it's useful.

cheers


--=-XCmPg9ERQhXBfMBIEDVL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzzNFAACgkQdSjSd0sB4dJ3SgCfS2b3StsZh+Trlz/cOdPZWVdw
Sx4An049jUWaP556KrIft5GOhaAjBZB9
=PRoR
-----END PGP SIGNATURE-----

--=-XCmPg9ERQhXBfMBIEDVL--
