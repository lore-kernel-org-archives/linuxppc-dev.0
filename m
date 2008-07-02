Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id D7FD2DE28C
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 18:41:42 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>,
 Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
Date: Wed, 2 Jul 2008 10:41:39 +0200
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
	<200807011049.32699.laurentp@cse-semaphore.com>
	<58163CFC-A697-4FF7-ADC5-A1B9C976965E@kernel.crashing.org>
In-Reply-To: <58163CFC-A697-4FF7-ADC5-A1B9C976965E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1350922.jEyJ1dvVkC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200807021041.40306.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1350922.jEyJ1dvVkC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 02 July 2008, Kumar Gala wrote:
>=20
> On Jul 1, 2008, at 3:49 AM, Laurent Pinchart wrote:
>=20
> > Hi Paul,
> >
> > On Tuesday 01 July 2008, Paul Mackerras wrote:
> >> The following commits have been added to the master and powerpc-next
> >> branches of the powerpc.git repository.  This includes patches pulled
> >> from Kumar's and Josh's trees.
> >
> > Any change of getting the following patches into 2.6.27 ? They have =20
> > either been acked and not picked, or just ignored so far :-/
> >
> > [PATCHv2] fs_enet: restore promiscuous and multicast settings in =20
> > restart()
> > 	http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D19228
>=20
> Should go via netdev unless jgarizk says otherwise

On 2008-06-18, Jeff wrote:

"My general rule is, anytime I see 80%+ of the patch dealing with=20
arch-specific API functions (such as OF resource stuff), I tend to=20
prefer that goes via an arch tree.

If it's a networking change, of course I'd prefer it came in my direction."

Jeff, could you please tell us if you want to pick this one or if it should=
 go through the powerpc tree ? The patch has been posted to both the linuxp=
pc-dev and netdev lists, and I haven't received any comment from the netdev=
 folks.

> > [PATCH 2/2] fs_enet: MDIO on GPIO support
> > 	http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D18693
>=20
> ditto

Jeff, same question :-)

> > [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2 =20
> > Freescale SoC.
> > 	http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D19045
>=20
> I'll look at this one

Thanks.

> > [PATCH] powerpc: Modem control lines support for the cpm_uart driver
> > 	http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D17928
>=20
> this seems to depend on the previous patch.

It doesn't strictly depend on the previous one. You will need GPIO LIB API =
on CPM2 to use the modem control lines, but the cpm_uart driver will fall b=
ack to the current behaviour if no GPIO LIB support is present.

> > [PATCH] cpm_uart: Support uart_wait_until_sent()
> > 	http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D19233
>=20
>=20
> applied

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1350922.jEyJ1dvVkC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhrP0QACgkQ8y9gWxC9vpdRagCeJzkxXqJNnUwI67mLtxBKtH/d
CqgAniFhg8o7UTxeGCjE2mG6Z7cUoPnA
=BlMw
-----END PGP SIGNATURE-----

--nextPart1350922.jEyJ1dvVkC--
