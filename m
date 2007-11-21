Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay007.isp.belgacom.be (mailrelay007.isp.belgacom.be
	[195.238.6.173]) by ozlabs.org (Postfix) with ESMTP id 71CF7DDEDD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 04:30:08 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Firmware Support for USB Hub
Date: Wed, 21 Nov 2007 18:29:59 +0100
References: <13877282.post@talk.nabble.com> <474468C5.8080402@freescale.com>
In-Reply-To: <474468C5.8080402@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1909474.Xya0fQoNH2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200711211830.02997.laurentp@cse-semaphore.com>
Cc: Misbah khan <misbah_khan@engineer.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1909474.Xya0fQoNH2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 21 November 2007 18:20, Scott Wood wrote:
> Misbah khan wrote:
> > Hi all,
> >
> > I am using a 8248 processor which has a USB controller and i need to
> > connect a USB Hub to it, iam using Montavista Linux .I need to know that
> > what are the support i need form Montavista or Open source to have an
> > interface with Usb hub. ???
> >
> > Is there any driver that we need to make if so what type ???
>
> I don't believe a driver currently exists for CPM USB.

There's an experimental out-of-tree driver available at=20
http://cpm2usb.sourceforge.net/

The code is outdated and doesn't work, but that's a starting point.

If I remember correctly, CPM2 USB host support requires the host to create =
SOF=20
packets in software. High system loads will probably mess the bus up. A=20
colleague of mines was told by Freescale to use an external USB controller=
=20
instead of the MPC8248 bundled one.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1909474.Xya0fQoNH2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHRGsa8y9gWxC9vpcRAvrHAJ9UWDcLi/zPDZg6ttaGmPeYs06RsQCeNJVs
Yc3oasV6DhyZAjxDiIv3PRE=
=SDZX
-----END PGP SIGNATURE-----

--nextPart1909474.Xya0fQoNH2--
