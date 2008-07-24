Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 6B6A6DE2DA
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 00:47:03 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
	Freescale SoC.
Date: Thu, 24 Jul 2008 16:46:57 +0200
References: <4808D75B.9000002@scram.de> <4880B730.8050801@scram.de>
	<C98DF5D7-0E3D-4FDA-A831-55CFD5F4590C@kernel.crashing.org>
In-Reply-To: <C98DF5D7-0E3D-4FDA-A831-55CFD5F4590C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7120205.pYC4cXeE2e";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200807241647.00564.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart7120205.pYC4cXeE2e
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Kumar,

On Friday 18 July 2008, Kumar Gala wrote:
> On Jul 18, 2008, at 10:30 AM, Jochen Friedrich wrote:
> >> On Jun 18, 2008, at 12:08 PM, Laurent Pinchart wrote:
> >>
> >>> +#if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
> >>> +
> >>> +struct cpm2_ioports {
> >>> +	u32 dir, par, sor, odr, dat;
> >>> +	u32 res[3];
> >>> +};
> >>> +
> >>
> >> is this really common for both CPM2 and 8xx?  if so why the name?
> >
> > It is common to CPM2 and Port E of CPM1.
>=20
> but ports a-d are different on cpm1?  I guess I'd like to see both =20
> patches to understand the commonality and differences.

As Jorgen mentionned, both patches are still in patchwork:

http://patchwork.ozlabs.org/linuxppc/patch?id=3D19045
http://patchwork.ozlabs.org/linuxppc/patch?id=3D19386

Would it be possible for you to review them in time for 2.6.27 ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart7120205.pYC4cXeE2e
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiIleQACgkQ8y9gWxC9vpfVGACgs1gXEn5r0Bnmkw/Yla36wUis
+XYAoJ35Hr9Y5zADQkBHBsafuEJ7rWak
=KII3
-----END PGP SIGNATURE-----

--nextPart7120205.pYC4cXeE2e--
