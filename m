Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 75D5CDE07B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 01:08:03 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
	Freescale SoC.
Date: Fri, 18 Jul 2008 17:07:56 +0200
References: <4808D75B.9000002@scram.de>
	<200807181638.42485.laurentp@cse-semaphore.com>
	<97D0950D-BBCA-4859-936E-774D887B05DC@kernel.crashing.org>
In-Reply-To: <97D0950D-BBCA-4859-936E-774D887B05DC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3539796.alFihqqb5Z";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200807181707.56921.laurentp@cse-semaphore.com>
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

--nextPart3539796.alFihqqb5Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 18 July 2008, Kumar Gala wrote:
>=20
> On Jul 18, 2008, at 9:38 AM, Laurent Pinchart wrote:
>=20
> > On Friday 27 June 2008, Jochen Friedrich wrote:
> >> Hi Laurent,
> >>
> >>> Is there any pending issue or can this be applied to powerpc-next ?
> >>
> >> Looks OK to me.
> >>
> >>>> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> >>>> Cc: Jochen Friedrich <jochen@scram.de>
> >> Acked-by: Jochen Friedrich <jochen@scram.de>
> >
> > Any news on this patch ? Kumar, could you apply it to your tree for =20
> > 2.6.27 ?
>=20
> Can you repost it.  I not sure what patch 2/2 was and if I've already =20
> dealt with it.

2/2 was "[PATCH2/2] [POWERPC] CPM1: implement GPIO LIB API on CPM1 Freescal=
e SoC." posted by Jochen Friedrich. You haven't dealt with it yet as far as=
 I know, but it would be up to Jochen to resubmit.

The "PATCHv3 1/2" patch can be considered as-is, as it doesn't depend on 2/=
2. Should I resubmit a "PATCHv4" that just changes the subject line ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart3539796.alFihqqb5Z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiAscwACgkQ8y9gWxC9vpe9FwCeJAPQIcoDhudLORKSjVdYaqmp
wMsAn2nYLnQwSfdgbMyfE5Ver+C7v/ad
=KQ+D
-----END PGP SIGNATURE-----

--nextPart3539796.alFihqqb5Z--
