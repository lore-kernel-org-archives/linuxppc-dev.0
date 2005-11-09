Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7F7E686DA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 23:05:37 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EZnY4-0007Y1-C9
	for linuxppc-embedded@ozlabs.org; Wed, 09 Nov 2005 11:51:24 +0100
Received: from dsl-202-45-109-210.vic.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 09 Nov 2005 11:51:24 +0100
Received: from ronkbox-news by dsl-202-45-109-210.vic.netspace.net.au with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 09 Nov 2005 11:51:24 +0100
To: linuxppc-embedded@ozlabs.org
From: Ron Kellam <ronkbox-news@yahoo.com>
Date: Wed, 09 Nov 2005 17:55:43 +1100
Message-ID: <bdv0n1le1g1bsnano4kr22omgl5p9ilbag@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: State of SPI for 2.4.25 kernel?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Help!  I was hoping to use SPI on an MPC8247 running the EDLK 2.4.25
kernel, but as I look into the code, I'm not hopeful...

Can someone fill me in on the state of SPI in the 2.24.xx kernels.
What about under 2.6.xx?  (although I haven't yet brought 2.6.xx up on
the custom board I've got).

I've currently resorted to bit-banging for I2C, as the MPC8260 algo
driver didn't seem to behave on an 8272 family CPU.  I was intending
on also going bit-banging for the SPI, but spi-algo-bit.c seems to be
in a half complete state and won't even compile.

Any info appreciated.

Thanks,
Ron Kellam.
