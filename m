Return-Path: <Leonid@a-k-a.net>
Received: from mis011-2.exch011.intermedia.net
	(mis011-2.exch011.intermedia.net [64.78.21.129])
	by ozlabs.org (Postfix) with ESMTP id 09273DDF43
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 04:28:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: I can I boot u-boot from flash on Virtex-4 based board
Date: Mon, 26 Feb 2007 09:28:18 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C0108DE92@ehost011-3.exch011.intermedia.net>
In-Reply-To: <45E2FEB8.1060007@lkmail.de>
References: <45E2FEB8.1060007@lkmail.de>
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

On Monday, February 26, 2007 7:37 AM Lorenz Kolb wrote:
> Easiest way is: write some mini-bootloader that fits into BRAM and
loads=20
> u-boot from flash.

That what I've done myself. It works perfectly for my Spartan and
Virtex-4 based boards. Simplest way is to compile binary to run from RAM
always and make this BRAM based early mini-bootloader copy image from
flash to RAM and then start. Remember that start function is not in the
beginning of this binary (for PPC 405 it has offset 0x100 normally).

> If you need some more detailed instructions and a patch created from=20
> Xilinx'u-boot tree to patch u-boot 1.20 to work with ML403 I can send
you > the files.

Can I have these? Also I'd appreciate to know where to get EDK project
for ML403 whose xparameters.h matches this u-boot patch.

Thanks,

Leonid.
