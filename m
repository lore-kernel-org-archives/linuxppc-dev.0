Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3711B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Oct 2010 20:33:12 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	o949X6Dm022563
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Oct 2010 11:33:06 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Ppc to PowerPC changes relating to XGPIO
Date: Mon, 4 Oct 2010 11:33:05 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201010041133.05945.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
when I was using the PPC kernel a couple versions back, I had modified the 
xgpio_ioctl.h file (and its related adapter.c) in order to extend the 
xgpio_ioctl() function with new commands for my needs.

But now I don't see where the equivalent code is located with the new 
architecture. How do I interact win GPIOs from usermode if not for ioctl calls 
? (I need to manipulate the direction bits, not just read/write values).

Note: I'm using the kernel provided by the Xilinx git, so maybe my question 
isn't relevant here.

Thanks
-- 
Guillaume Dargaud
http://www.gdargaud.net/
