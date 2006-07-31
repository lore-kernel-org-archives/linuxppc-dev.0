Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 8C7D867B52
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 16:01:17 +1000 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: USB flashdrive on Motorola MPC5200 (IceCube) board,
	linux ker nel 2.4.25 (DENX drop)
References: <162B449665D6D643AD9E1D50FC6F4B14042F1C9A@mdcexc05.na.ops.local>
In-Reply-To: <162B449665D6D643AD9E1D50FC6F4B14042F1C9A@mdcexc05.na.ops.local>
MIME-Version: 1.0
Message-ID: <200607310753.54277.roman.fietze@telemotive.de>
Date: Mon, 31 Jul 2006 07:53:50 +0200
Content-Type: multipart/signed; boundary="nextPart4389181.hxUKgS3HGk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart4389181.hxUKgS3HGk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

On Saturday 29 July 2006 00:07, Furxhi, Orges wrote:

> usb.c: USB device not accepting new address=3D2 (error=3D-110)

We had that problem on a few of our boards as well.

=46or the old Icecube exists the possibility to mount two different USB
transceivers, one of them the ISP1107DH, the other one the
P11PAPW. Which one of the two is mounted on your board?

On our own boards we had problems with low speed devices and the
ISP1107, the other transceiver that Freescale used worked
fine. Connecting those low speed devices via a hub worked. Sometimes
it helped to add an additional capacitor to the power lines, but
that's not really a viable solution.

We ended up using a Fairchild USB1T11A, the ISP1107 seemed to have a
problem, we just didn't have luck with them. The Fairchild's are pin
compatible, maybe you just give it a try.


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--nextPart4389181.hxUKgS3HGk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEzZryp5XY/BK//MIRAn0xAJ9VvXd4qfAaJz0tPsBDMHotXK00uwCghpuB
rLHWCPG0yO6pns+jTKBWcko=
=98BB
-----END PGP SIGNATURE-----

--nextPart4389181.hxUKgS3HGk--
