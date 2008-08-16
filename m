Return-Path: <hachti@hachti.de>
Received: from ente.hachti.de (ente.hachti.de [212.227.83.80])
	by ozlabs.org (Postfix) with ESMTP id 2E1AFDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Aug 2008 05:53:21 +1000 (EST)
Received: from [192.168.0.19] (pD955BE3F.dip.t-dialin.net [217.85.190.63])
	by ente.hachti.de (Postfix) with ESMTPSA id 96F1333687C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 21:54:16 +0200 (CEST)
Message-ID: <48A7302F.8030707@hachti.de>
Date: Sat, 16 Aug 2008 21:53:19 +0200
From: Philipp Hachtmann <hachti@hachti.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: U-boot and Xilinx emaclite, TX_PING_PONG -> stops working
References: <931ae8260808160434g1ff6d856n46e5e420e487db57@mail.gmail.com>
In-Reply-To: <931ae8260808160434g1ff6d856n46e5e420e487db57@mail.gmail.com>
Content-Type: text/plain; charset=GB2312
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I use a Xilinx Virtex-4FX (with powerpc) Board (Ml403) with U-boot and
Linux.

I am currently wondering if someone has experience with the emaclite
driver. When I unset the "ping pong" (double buffering) parameters of
the core, I can use it unter Linux and U-boot. But the performance is
near to non-functional (wget tells me about 10kByte/sec).
Then I switched to double buffering. Now it runs very well - but only
under Linux.

I found a driver (xilinx_emaclite.c) in the U-boot git. That completely
refuses to work correctly (of course with parameters corrected). The
other driver I once found "somewhere" (in the Petalinux distribution).
It at least worked without the double buffering. Both drivers talk about
the ping pong options in their source, so I think they *should* know
about it.


Does anyone know that problem? Is there an improved driver around?

Best wishes,

Philipp





-- 
http://www.hachti.de
