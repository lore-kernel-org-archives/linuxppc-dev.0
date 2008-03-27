Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id E88A4DDF67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 19:56:16 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Help on MPC82XX USB Host controller Development using m82xx-hcd.
Date: Thu, 27 Mar 2008 09:56:08 +0100
References: <16304553.post@talk.nabble.com>
In-Reply-To: <16304553.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2518462.UbrbQDQBuQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803270956.12203.laurentp@cse-semaphore.com>
Cc: Amarendra_Reddy <amar1567@yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart2518462.UbrbQDQBuQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Amarendra,

On Wednesday 26 March 2008 17:11, Amarendra_Reddy wrote:
>=20
> Hi all,
>=20
> We are working on implementation of the USB host controller driver for the
> MPC8272ADS (eval board).=20
>=20
> The USB Host controller on MPC8272 chip is neither UHCI nor OHCI complian=
t.=20
>=20
> We downloaded the project cpm2usb and the patches created by Mr.Mike
> Rapoport from http://cpm2usb.sourceforge.net
>=20
> We integrated the 'm82xx-hcd' into the 2.6.10 source with few changes to =
usb
> data structures (usb_hcd,usb_device,usb_host_endpoint) and to struct
> hc_driver. Also updated the function ''tx_err' present in m82xx-hcd.c.

The cpm2usb project isn't maintained. If possible you should upgrade to a m=
ore=20
recent kernel and switch to the powerpc architecture where a new USB driver=
=20
called fhci is available.

The MPC872ADS is supported in recent kernels so switching shouldn't be too=
=20
difficult.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2518462.UbrbQDQBuQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH62Es8y9gWxC9vpcRAnvrAJ0QLJOQKGJraun2yMCxSnNZlcsUAQCg357a
IbWND7Na+q+TNtcJypJMzAw=
=QmMC
-----END PGP SIGNATURE-----

--nextPart2518462.UbrbQDQBuQ--
