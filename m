Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 411D7DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 06:37:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: BDI2000 configuration file for MPC8313E-RDB
Date: Wed, 16 May 2007 13:37:13 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C017BA257@ehost011-3.exch011.intermedia.net>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E8491767CF@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E8491767CF@ex01.ads.ubidyne.de>
From: "Leonid" <Leonid@a-k-a.net>
To: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

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
