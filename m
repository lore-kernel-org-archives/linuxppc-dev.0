Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id 70D3D68621
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Nov 2005 01:16:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 3 Nov 2005 15:16:20 +0100
Message-ID: <47F3F98010FF784EBEE6526EAAB078D1C05E6C@tq-mailsrv.tq-net.de>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Mark Chambers" <markc@mail.com>,
	"Clemens Koller" <clemens.koller@anagramm.de>,
	"Absolut Hunter" <absoluthunter@comcast.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: SM501 Frame Buffer driver on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark Chambers wrote on Thursday, November 03, 2005 3:06 PM:=20
> > The endianess on PCI on ppc is still an issue (I haven't
> > investigated this problem further during the last month).
> >=20
>=20
> There really shouldn't be an endian issue on SM501 since registers are
> 32 bit.  What we do have is the 5200 that does byte swapping on PCI
> for no good reason (IMHO)

We experienced a byte swapping issue on the SM501, too, although it
is connected via the local plus bus with the MPC5200 and not via PCI
bus.

In 16 bpp mode bytes appear to be swapped in a very ugly way.
Unfortunately we have no explanation for this, nor a real
workaround.

-- Martin Krause
