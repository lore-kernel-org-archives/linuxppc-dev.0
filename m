Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay012.isp.belgacom.be (mailrelay012.isp.belgacom.be
	[195.238.6.179]) by ozlabs.org (Postfix) with ESMTP id 9A2E4DE2AC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Oct 2007 03:43:28 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: videobuf
Date: Tue, 30 Oct 2007 17:43:16 +0100
References: <1193758138.4606.7.camel@PisteOff>
In-Reply-To: <1193758138.4606.7.camel@PisteOff>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20238222.2pi5z5mQ3G";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200710301743.18580.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart20238222.2pi5z5mQ3G
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 30 October 2007 16:28, Robert Woodworth wrote:
> I'm  working on building a v4l2 driver for an FPGA module on a Xilinx
> Virtex4 PPC.
>
> Question:
> Why does the v4l2 videobuf *depend* on PCI?

Historical reasons I guess. The videobuf module has been designed for PCI=20
hardware (bttv if I'm not mistaken). Now that other, non-PCI devices would=
=20
benefit from videobuf, PCI-specific support is being moved to a separate=20
module.

Search the video4linux mailing list archive for discussions about videobuf=
=20
cleanup. You can get the latest source tree at www.linuxtv.org.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart20238222.2pi5z5mQ3G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHJ18m8y9gWxC9vpcRArdXAJ4kuvlJ7GGEkzEiiMlUOk2JNzX0iQCeJVVc
svHtWqZm1H/SfM1mnW9Mbks=
=UmiR
-----END PGP SIGNATURE-----

--nextPart20238222.2pi5z5mQ3G--
