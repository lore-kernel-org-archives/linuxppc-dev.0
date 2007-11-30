Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
	[195.238.6.53]) by ozlabs.org (Postfix) with ESMTP id 474B8DDEA3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 23:30:31 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: CPM2 USB host driver
Date: Fri, 30 Nov 2007 13:30:18 +0100
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<20071130141638.4e00258d@kernel.crashing.org>
In-Reply-To: <20071130141638.4e00258d@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2699371.bMhLTZ6MzH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200711301330.25100.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, mike@compulab.co.il
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2699371.bMhLTZ6MzH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 30 November 2007 12:16, Vitaly Bordug wrote:
> On Fri, 30 Nov 2007 11:45:49 +0100
>
> Laurent Pinchart wrote:
> > Hi everybody,
> >
> > Linux USB host support for the CPM, CPM2 and CPM2 pro is far from
> > complete. Many people showed interest on this list (and on
> > linuxppc-embedded) in the past, but nobody managed to complete a
> > driver and get it merged.
>
> that is mainly because of its semi-software nature. However, any approach
> would be helpful I beleive.

The CPM/CPM2 USB host controller does indeed put some pressure on the CPU. =
The=20
PowerQuick III family is much better in that respect as its USB host=20
controller is EHCI compliant.

We plan to use an external USB host controller when we will redesign the=20
hardware. My goal in writting a CPM2 USB host driver is mainly to enable th=
e=20
hardware team to perform EMC testing on the USB interface. I don't expect i=
t=20
to be shipped to any client, but I'd still like to get it merged (if I=20
complete the project) as I don't like throwing away useful code.

> > As I need USB host support on my MPC8248 (CPM2), I decided to scratch
> > the itch and try to get a working driver that could be merged
> > upstream. This mail describes my plans to make sure the code I write
> > will be useful for other people.
> >
> > The driver will be based on the cpm2usb project
> > (http://cpm2usb.sf.net/). As I don't own any CPM1-based platform, I
> > will convert the driver to use the CPM2 transaction-level interface,
> > thus making it incompatible with the CPM1. CPM1 support could be
> > added back later. There is no planned release date, and more urgent
> > projects could put this development on hold.
> >
> > Comments are welcome (and contributions too, especially in the form
> > of a working driver :-)).
>
> I may have some WIP material left, will try to dig it out...

Should I wait ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2699371.bMhLTZ6MzH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHUAJh8y9gWxC9vpcRAvdxAKDhKtpeJn8sPgN0RCc8JZCXt6QCtACg3RAL
qCgCKLxGfedq7KYPx38AY/E=
=cdTj
-----END PGP SIGNATURE-----

--nextPart2699371.bMhLTZ6MzH--
