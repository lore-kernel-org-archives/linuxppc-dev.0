Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 2D9C1DE256
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 18:36:49 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: patches for 2.6.27...
Date: Wed, 2 Jul 2008 10:36:43 +0200
References: <068935A1-11BE-4AEB-9C0E-E1AB53F1618E@kernel.crashing.org>
In-Reply-To: <068935A1-11BE-4AEB-9C0E-E1AB53F1618E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1256493.OWZg95zOW5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200807021036.46603.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1256493.OWZg95zOW5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Kumar,

On Wednesday 02 July 2008, Kumar Gala wrote:
> Please point out any patches that have been posted but havent made it =20
> into a git tree related to Freescale chips.
>=20
> I know there are probably a slew of CPM patches that need to get into =20
> the tree.

Here are 5 patches that I'd like to see in 2.6.27. They haven't made into a=
ny git tree as far as I know.

[PATCHv2] fs_enet: restore promiscuous and multicast settings in restart()
        http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D19228
[PATCH 2/2] fs_enet: MDIO on GPIO support
        http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D18693
[PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2 Freescale SoC.
        http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D19045
[PATCH] powerpc: Modem control lines support for the cpm_uart driver
        http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D17928
[PATCH] cpm_uart: Support uart_wait_until_sent()
        http://patchwork.ozlabs.org/linuxppc/patch?person=3D968&id=3D19233

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1256493.OWZg95zOW5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhrPh4ACgkQ8y9gWxC9vpd1HACfZJJzNziZrSuOQaOQhHjANg7N
hBUAoIURLIysNSMLaAmHbgbK4B1BRJod
=G6hd
-----END PGP SIGNATURE-----

--nextPart1256493.OWZg95zOW5--
