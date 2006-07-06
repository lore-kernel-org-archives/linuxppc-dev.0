Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FE90679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jul 2006 23:33:47 +1000 (EST)
Received: from minster.cs.york.ac.uk ([144.32.40.2])
	by mailgw.cs.york.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.60) (envelope-from <ammubhai@gmail.com>) id 1FyTx3-0000sQ-1B
	for linuxppc-embedded@ozlabs.org; Thu, 06 Jul 2006 14:31:29 +0100
Received: from pc112.ad.cs.york.ac.uk ([144.32.81.113])
	by minster.cs.york.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.60) (envelope-from <ammubhai@gmail.com>) id 1FyTx3-0000Y2-4I
	for linuxppc-embedded@ozlabs.org; Thu, 06 Jul 2006 14:31:29 +0100
Message-ID: <44AD10AF.10802@gmail.com>
Date: Thu, 06 Jul 2006 14:31:27 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx BSP for linux 2.6
References: <BAY110-F18951B1690B257545F5EEB2770@phx.gbl>
In-Reply-To: <BAY110-F18951B1690B257545F5EEB2770@phx.gbl>
Content-Type: text/plain; charset=GB2312
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ming,
  I DONOT have a ML403 with me. But does Xilinx EDK generate
xparameters_ml300.h in the BSP instead of xparameters_ml403.h for the
ML403 board?

Anyway, for linux 2.6 theres no xilinx_ocp directory in the code tree.
You need to just copy the xparameters_ml300.h file (if that is what
xilinx EDK generates) as xparameters_ml403.h in
arch/ppc/platforms/4xx/xparameters/ folder. Configure the kernel as ML403.

Like I said to you before, if you want to get started quickly and
without much headache.. then please go step-by-step. Try the things I
mention in the article PART I without applying any patches.

http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/

Then if your kernel boots and shows some messages, it would be much
easier to relate to problems after applying patches.

Please DONOT hesitate to ask further clarifications!

-Ameet

Ming Liu wrote:
> Dear Ameet,
> Now I am using your patch for SystemACE in Linux 2.6. My linux version 
> is 2.6.16-rc5 and I have applied the patch for SystemACE and Temac.
> When I generate BSP in EDK, how can I implement it in my linux kernel? I 
> know the EDK BSP is for Linux 2.4 and the directory stucture is the same 
> as 2.4(e.g. arch/ppc/platform/xilinx_ocp/......) But in 2.6, the 
> directory tree is different and I cannot simply copy and replace the 
> original files there. Also, there is a file called xparameters_ml403.h 
> in Linux kernel but in BSP there is only xparameters_ml300.h. Shall I 
> rename the xparameters_ml300 as ml403, or configure the board as ml300 
> in menuconfig? In these xparameters files, the peripheral addresses are 
> defined. How can I include these xparameters defination in the kernel? 
> It looks complicate and you didn't mention how to replace these files in 
> your article. So if you can provide some guidance, I will appreciate a 
> lot because it will save me much time.
> By the way, I am still waiting for the last part of your article. Where 
> are they? :)
> 
> Thanks for your help.
> 
> Regards
> Ming
> 
> _________________________________________________________________
> 享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com 
> 
