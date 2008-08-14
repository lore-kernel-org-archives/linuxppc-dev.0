Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id EB537DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 22:15:47 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org,
 avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/3] Patches to support QE USB Host Controller
Date: Thu, 14 Aug 2008 14:15:37 +0200
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
In-Reply-To: <20080808161717.GA19095@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15632004.JyQgAgK3b9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200808141415.42109.laurentp@cse-semaphore.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart15632004.JyQgAgK3b9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 08 August 2008, Anton Vorontsov wrote:
> Hi all,
>=20
> Most patches that were needed to support QE USB Host were merged during
> 2.6.27 merge window, and only three more patches left over. Here they
> are.
>=20
> David, could you bear with gpio_to_chip() exported function, just as
> a stopgap for a proper api?

I need gpio_to_chip() (or another 'proper API') as well for RTS/CTS based f=
low control in the CPM/CPM2 UART driver.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart15632004.JyQgAgK3b9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkikIe4ACgkQ8y9gWxC9vpcmlACdE3MeY089shx+6b/k46phPYCA
LYIAoJ92hIim9i81dEaH+Q9m3raFDGRX
=tyOo
-----END PGP SIGNATURE-----

--nextPart15632004.JyQgAgK3b9--
