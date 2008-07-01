Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id C1FDFDE15F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 18:49:48 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
Date: Tue, 1 Jul 2008 10:49:29 +0200
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
In-Reply-To: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2283295.p4jTjbVQGB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200807011049.32699.laurentp@cse-semaphore.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2283295.p4jTjbVQGB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,

On Tuesday 01 July 2008, Paul Mackerras wrote:
> The following commits have been added to the master and powerpc-next
> branches of the powerpc.git repository.  This includes patches pulled
> from Kumar's and Josh's trees.

Any change of getting the following patches into 2.6.27 ? They have either =
been acked and not picked, or just ignored so far :-/

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

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2283295.p4jTjbVQGB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhp75wACgkQ8y9gWxC9vpdCNACeLYppdhSyvu42kwFOPcVQ/1lD
GRsAoJzRQu+8OEcVvdTQhpF2Ev8MRWj9
=VglR
-----END PGP SIGNATURE-----

--nextPart2283295.p4jTjbVQGB--
