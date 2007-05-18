Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ex01.ads.ubidyne.de (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 54023DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 May 2007 16:00:40 +1000 (EST)
Subject: AW: BDI2000 configuration file for MPC8313E-RDB
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 18 May 2007 08:00:24 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E84917683B@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Leonid <Leonid@a-k-a.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Leonid,

firstly, thanks for reply!

But, are you sure that I cannot access NAND memory via=20
BDI2000? Because I used BDI2000 with the MPC8343M Board=20
and there is "only" 64MB NAND memory. Thus I stored the=20
U-Boot (image was broken) into the flash memory.

Frank


-----Urspr=FCngliche Nachricht-----
Von: Leonid [mailto:Leonid@a-k-a.net]=20
Gesendet: Mittwoch, 16. Mai 2007 22:37
An: Frank Prepelica; linuxppc-embedded@ozlabs.org
Betreff: RE: BDI2000 configuration file for MPC8313E-RDB

AFAIK, BDI2000 doesn't support NAND... of course you can load some code
which has NAND support into RAM (even u-boot if compiled properly) and
thus program NAND flash. But BDI firmware cannot program NAND directly.

Leonid.

________________________________________
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf
Of Frank Prepelica
Sent: Wednesday, May 16, 2007 7:25 AM
To: linuxppc-embedded@ozlabs.org
Subject: BDI2000 configuration file for MPC8313E-RDB

Hi all,

maybe this is not the appropriate mailing list, sorry for that!

but, does anyone got a working BDI2000 configuration file + reg.
definitions for MPC8313E-RDB
to get access to NAND memory? I got one but there's only access to NOR
memory.

Many thanks in advance!

Best regards
Frank
