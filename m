Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id DC9F9DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 18:49:28 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id E4D2A99E3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 08:49:18 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK 3.1.1: PCI Video Cards on Lite5200B
References: <45A3BE1F0200007100004438@webmail.nearfield.com>
In-Reply-To: <45A3BE1F0200007100004438@webmail.nearfield.com>
MIME-Version: 1.0
Message-ID: <200701110849.18317.roman.fietze@telemotive.de>
Date: Thu, 11 Jan 2007 08:49:18 +0100
Content-Type: multipart/signed; boundary="nextPart1217135.xUcZoEerVL";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1217135.xUcZoEerVL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hallo Michael,

On Wednesday 10 January 2007 01:09, Michael Carey wrote:

> Has anyone gotten a pci video card to work on a Lite5200B board?

Yes, but only the Coral-P, and X11 only correctly using a modified X
server (xfree86 and xorg).

The problem is the endianess. The Coral-P does not contain a byte
swapper for the video memory, so it cannot be easily be used with a
big endian CPU like many other grafik chips. Even the successor of the
Coral-P has such a byte swapper.

Our modifications to support Z-images are done in the non-accelerated
driver in the shadow frame buffer extension.

The Coral-P accelerated driver wasn't very stable when we tested it a
while ago, I assume this very much depends on the functions you use.


Roman

=2D-=20
Roman Fietze Telemotive AG B=FCro M=FChlhausen


--nextPart1217135.xUcZoEerVL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFpev+p5XY/BK//MIRApgDAJ9ml/9GtOPw6MyOVf10GaXf1gg4SACeJJTi
Cp1MLQ9nVImfeUqFM9YkI1Q=
=jTnH
-----END PGP SIGNATURE-----

--nextPart1217135.xUcZoEerVL--
