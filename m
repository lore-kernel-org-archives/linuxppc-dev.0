Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id DBB5DDE06E
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 21:58:54 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 8719C663A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 11:58:49 +0100 (CET)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 612125065
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 11:58:49 +0100 (CET)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Interrupt handling documentation
Date: Tue, 11 Mar 2008 11:58:45 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14019155.HfdIyVySCb";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803111158.48540.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart14019155.HfdIyVySCb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

is there any documentation describing interrupt handling for the powerpc=20
architecture ? I'm writing a driver for a cascaded interrupt controller and=
=20
the only source of information I found was the code.

I'm particularly interested in information about irq hosts (allocation and=
=20
initialisation, especially the map and unmap callbacks) and irq chaining.=20
Different drivers seem to implement cascaded irqs differently (for instance=
=20
arch/powerpc/sysdev/uic.c uses setup_irq to register the cascaded irq=20
handler, while arch/powerpc/platforms/82xx/pq2ads-pci-pic.c uses=20
set_irq_chained_handler) so I'm a bit lost here.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart14019155.HfdIyVySCb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH1mXo8y9gWxC9vpcRAgt4AKCatWiEuLmQpjK7b97oXn7JmywJJQCgkzuG
4UUjj7YxSa8eUlMNkUKV90M=
=WQCm
-----END PGP SIGNATURE-----

--nextPart14019155.HfdIyVySCb--
