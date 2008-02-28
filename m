Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 2DE68DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 23:49:11 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id EEAC04A3A
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 13:49:08 +0100 (CET)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id D1E3437F5
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 13:49:08 +0100 (CET)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] fs_enet: Remove unused fields in the
	fs_mii_bb_platform_info structure.
Date: Thu, 28 Feb 2008 13:49:01 +0100
References: <200802151427.44321.laurentp@cse-semaphore.com>
In-Reply-To: <200802151427.44321.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1665545.khtHujFyc6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802281349.07501.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1665545.khtHujFyc6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 15 February 2008 14:27, Laurent Pinchart wrote:
> The mdio_port, mdio_bit, mdc_port and mdc_bit fields in the
> fs_mii_bb_platform_info structure are left-overs from the move to the Phy
> Abstraction Layer subsystem. They can be safely removed.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
[snip]

Is there something wrong with the patch ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1665545.khtHujFyc6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHxq3D8y9gWxC9vpcRAmS+AJ9QkzTBIyQUwQSj1PWp6vc7Ug8NqACfUHGt
EU7uZJUICWcPaOmixnYfgg4=
=OCXK
-----END PGP SIGNATURE-----

--nextPart1665545.khtHujFyc6--
