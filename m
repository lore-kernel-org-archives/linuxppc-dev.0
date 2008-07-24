Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id CCA3EDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jul 2008 19:19:50 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KLwzC-0000M7-Jo
	for linuxppc-embedded@ozlabs.org; Thu, 24 Jul 2008 02:19:46 -0700
Message-ID: <18628194.post@talk.nabble.com>
Date: Thu, 24 Jul 2008 02:19:46 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem
In-Reply-To: <20080316214832.3F77A538046@mail141-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com>
	<20080316214832.3F77A538046@mail141-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear All,

I have done a design using EDK 8.2 using Hard_Temac IP component. In the EDK
9.2 there is a new idea to use ll_temac in conjunction with ll_fifo or
ll_dma. So far I was using happily the linux kernel by Grant Likey.
Unfortunately it does not deal with ll_temac. I have download the kernel
from git.xilinx.com.

I have tried to build the kernel 2.6.26  (by xilinx) but it seems to be that
it is not well prepared for ll_fifo.
I have noticed that in drivers/xilinx_common there are files related to
ll_fifo but in the drivers/Makefile there is no rule to build ll_fifo. The
same refers to the file arch/ppc/syslib/virtex_devices.c ->  there are no
entries for LL_FIFO. I have the impression that one can use only LL_DMA but
not LL_FIFO.

Does anybody has modified the kernel to deal with LL_TEMAC together with
LL_FIFO?
I will be grateful for any hint.

Best Regards

Mirek
-- 
View this message in context: http://www.nabble.com/Compile-time-error%2C-compiling-Xilinx-Linux-2.6-for-XPS-LLTEMAC-tp16065692p18628194.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
