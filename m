Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id 3986067A81
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Feb 2005 23:55:27 +1100 (EST)
Message-ID: <002b01c50d14$d5f6b770$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <francois.ruvoen@libertysurf.fr>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <IBJDLO$2F7CB4091C41824099E5E47AB0570FD3@tiscali.fr>
Date: Mon, 7 Feb 2005 07:59:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Microwindows on Icecube/CoralP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>I have been playing with the CoralP, Icecube and Debian.
>Works fine, thanks to the tutorial on the Denx site.
>I now would like to see the microwindows stuff working. I
>have been trying the demos from the ELDK but I get strange
>colors, it seems my palette is all wrong. The same happens
>when I recompile the latest version of microwindows (except
>I get yet another palette).
>Any pointers?

One unexpected thing about the 5200 is that it swaps bytes
to/from the PCI buss.  So if you write a 32 bit pixel, for
instance 0x12345678, it will be written to PCI as
0x78563412.  Presumably this is based on an assumption
that PCI targets will be little-endian.  So you might try
reversing bytes and see if the palettes make sense.

Mark Chambers
