Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 27A35DE064
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jul 2008 22:55:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem
Date: Thu, 24 Jul 2008 07:55:44 -0500
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333FFA5D56@XMBIL132.northgrum.com>
In-Reply-To: <18628194.post@talk.nabble.com>
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl><EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com><20080316214832.3F77A538046@mail141-sin.bigfish.com>
	<18628194.post@talk.nabble.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "Mirek23" <miroslaw.dach@psi.ch>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mirek,

I'm currently using the driver (CONFIG_XILINX_LLTEMAC) with the DMA
portion with no problem, which is what you kind of eluded to. From what
I've seen, the drver source does support the FIFO portion. It just
relies on having the proper definition for the TEMAC in either the DTS
or the xparameters.

I'm currently using the 2.6.26-rc8 kernel (HEAD?) from git.xilinx.com as
well, and mine builds with no problem for arch/ppc. Yes, I still have
not moved to arch/powerpc. I will be moving to the new arch in the very
near future. (My current test system is actually a mish-mash of 2.6.22
w/ the driver from xilinx-2.6.26 tree).=20

Are you using arch/powerpc or arch/ppc? Are you generating your DTS from
your MHS file using the bsp generator for EDK on git.xilinx.com? Is this
for one of the reference boards (ML403, ML405, etc)? What is the problem
that you're having with the build of the kernel?

-- Mike

-----Original Message-----
From: Mirek23 [mailto:miroslaw.dach@psi.ch]=20
Sent: Thursday, July 24, 2008 5:20 AM
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem


Dear All,

I have done a design using EDK 8.2 using Hard_Temac IP component. In the
EDK
9.2 there is a new idea to use ll_temac in conjunction with ll_fifo or
ll_dma. So far I was using happily the linux kernel by Grant Likey.
Unfortunately it does not deal with ll_temac. I have download the kernel
from git.xilinx.com.

I have tried to build the kernel 2.6.26  (by xilinx) but it seems to be
that it is not well prepared for ll_fifo.
I have noticed that in drivers/xilinx_common there are files related to
ll_fifo but in the drivers/Makefile there is no rule to build ll_fifo.
The same refers to the file arch/ppc/syslib/virtex_devices.c ->  there
are no entries for LL_FIFO. I have the impression that one can use only
LL_DMA but not LL_FIFO.

Does anybody has modified the kernel to deal with LL_TEMAC together with
LL_FIFO?
I will be grateful for any hint.

Best Regards

Mirek
--
View this message in context:
http://www.nabble.com/Compile-time-error%2C-compiling-Xilinx-Linux-2.6-f
or-XPS-LLTEMAC-tp16065692p18628194.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
