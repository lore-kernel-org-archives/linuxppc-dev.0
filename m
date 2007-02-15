Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 375CFDDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 15:57:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How can I boot a program from flash on ML403?
Date: Wed, 14 Feb 2007 20:57:11 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3CF9D7A1@ehost011-3.exch011.intermedia.net>
In-Reply-To: <000001c74fa0$ce627870$10b2a8c0@lorenzulm>
References: <mailman.120.1171370674.21008.linuxppc-embedded@ozlabs.org>
	<000001c74fa0$ce627870$10b2a8c0@lorenzulm>
From: "Leonid" <Leonid@a-k-a.net>
To: "Lorenz Kolb" <linuxppcemb@lkmail.de>,
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

Sent: Tuesday, February 13, 2007 10:57 AM Lorenz Kolb:
> Thus my current (dirty) solution is:

> Using SREC Bootloader from Xilinx' EDK to load a U-Boot and make
U-Boot=20
> load Linux both located on flash.
> Actually, it is quick and dirty, but it works fine for testing...

I use the same scheme (called 3-stage boot) but I don't see what is
dirty about it. For testing/debugging you even can load u-boot directly
into memory using XMD. Of course, image must be compiled to run from
memory, not flash.

BTW, do you (or anybody) have XTEMAC drivers for ML403 u-boot?

Regards,

Leonid.
