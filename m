Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id A50A2DE609
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 02:09:44 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: avorontsov@ru.mvista.com
Subject: Re: [RFC fs_enet: Convert MII bitbang driver to use GPIO lib
Date: Wed, 16 Apr 2008 18:09:36 +0200
References: <200804161640.42693.laurentp@cse-semaphore.com>
	<20080416160540.GB442@polina.dev.rtsoft.ru>
In-Reply-To: <20080416160540.GB442@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1761117.mnrTjv6ExC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804161809.40805.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1761117.mnrTjv6ExC
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 16 April 2008 18:05, Anton Vorontsov wrote:
> On Wed, Apr 16, 2008 at 04:40:42PM +0200, Laurent Pinchart wrote:
> > This patch converts the MII bitband driver to use GPIO lib for GPIO
> > access. The driver can now handle MDC and MDIO on different GPIO banks.
> >=20
> > The patch depends on Anton Vorontsov GPIO lib support scheduled for
> > 2.6.26. It is by no means complete, I just would like to get some feedb=
ack
> > on the approach. I'll resubmit it when the CPM2 GPIO support patches wi=
ll
> > be available in the powerpc git tree.
>=20
> Cool! By the way, maybe it is worth splitting it into completely separate
> driver, e.g. net/mdio_gpio.c?

Splitting it into a completely separate driver makes sense.

> Plus, keep in mind that somebody will eventually want this cool stuff with
> platform_device bindings in addition. :-)=20

I'm sure that person will be happy to implement platform_device bindings :-)

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1761117.mnrTjv6ExC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBiTE8y9gWxC9vpcRAlJWAJ9bFDnFlBaM1G/1281Zt8e3fPd/5QCgsNJz
0irhTMTWAkXkxxnmhIznvPA=
=2ZBP
-----END PGP SIGNATURE-----

--nextPart1761117.mnrTjv6ExC--
