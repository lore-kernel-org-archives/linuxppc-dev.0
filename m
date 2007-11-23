Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay006.isp.belgacom.be (mailrelay006.isp.belgacom.be
	[195.238.6.172]) by ozlabs.org (Postfix) with ESMTP id 95ABDDDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 23:23:57 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Firmware Support for USB Hub
Date: Fri, 23 Nov 2007 13:23:43 +0100
References: <13877282.post@talk.nabble.com> <13908701.post@talk.nabble.com>
In-Reply-To: <13908701.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1409092.p81baav7ZD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200711231323.50212.laurentp@cse-semaphore.com>
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

--nextPart1409092.p81baav7ZD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 23 November 2007 09:45, Misbah khan wrote:
> This is the reply that i got from the Freescale :-
>
> --------------------------------------------------------------------------
> Reply from Freescale
> In reply to your Service Request SR 1-403672820:
>
> We recommend using the MPC8272 USB controller.
> We know that customers use the MPC8272/MPC8248 USB controller.
> You can find also USB drivers in Linux software for the MPC8272.
> For example Linux BSP for Freescale MPC8272ADS contains USB slave
> driver
> (http://www.freescale.com/webapp/sps/site/overview.jsp?nodeId=3D012726006=
1033
>202A5).
>
> Linux USB driver is available in the Arabella Linux
> (http://www.arabellasw.com/products-pow2.php).
>
> If the MPC8272 is USB host, the transaction-level interface can be used.
>
> Note: The MPC8272 USB does not support high-speed mode. It can
> operate on low-speed mode (1.5MHz) or full-speed mode (12MHz).
>
> -------------------------------------------------------------------------=
=2D-
>
> Can any body comment on this and help me how to start with and requirement
> is this :-
>
> I need a USB Hub to be connected to the PPC8248 board with Montavista Lin=
ux
> 2.6.10 on it what shall i do to achive it ....????The challenges you alre=
ady
> know=20

You need a USB host driver for the CPM2 controller. There are several=20
solutions:

=2D Start with the driver available at http://cpm2usb.sourceforge.net/ and =
port=20
it for your kernel.
=2D Ask Montavista support for a CPM2 USB host driver (they will most likel=
y=20
charge for that).
=2D Buy the Arabella kernel and port the driver to the Montavista kernel (a=
sk=20
the Arabella support to make sure their USB host driver supports what you=20
need, and pay attention to possible license issues).

In the end, it boils down to writing code yourself or paying someone to do =
the=20
job.

Best regards,

Laurent Pinchart

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1409092.p81baav7ZD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHRsZW8y9gWxC9vpcRAtKdAKCjZ7m5awpMqdO3DyTDh27jDYqyrACeMb8v
tCTeSdCnq6GZN+YodgTb2C0=
=iDUX
-----END PGP SIGNATURE-----

--nextPart1409092.p81baav7ZD--
