Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4814468A21
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 21:54:40 +1100 (EST)
Date: Fri, 27 Jan 2006 16:37:20 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Jose =?UTF-8?B?RnJhbsOnYQ==?= (Ext_GTBC) <Jose.Franca.Ext@siemens.com>
Subject: Re: HELP! Memory mapping and address space doubts
Message-ID: <20060127163720.0f671eaa@vitb.ru.mvista.com>
In-Reply-To: <16FD2D70D281D44F9BFCF6ACF9B6117102AF731A@lisi053a.siemens.pt>
References: <16FD2D70D281D44F9BFCF6ACF9B6117102AF731A@lisi053a.siemens.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jose,
Can you please be a bit more specific in targets you want to achieve?

An example how to setup br/or and use the device could be found as a part of PQ2 PCI support,
where interrupt controller is implemented as a CPLD device (arch/ppc/syslib/m82xx_pci.{c,h}).


On Thu, 26 Jan 2006 14:04:49 -0000
Jose França (Ext_GTBC) <Jose.Franca.Ext@siemens.com> wrote:

> Hello u all!
> 
> 	I need to clarify some aspects of the memory management in ppc linux and i hope that you could help me.
> 	Lets imagine we have a mpc8272 based board with 3 devices A, B and C.In the bootloader (in my case, i use u-boot), i configured the BRx and Orx so that A has base address X, B has base address Y and C has base address Z. My first doubt arrises here: what address should i use? Being SDRAM base address 0x00000000 and kernel base address 0xC0000000, where will i put these devices mapped on? Above 0xC0000000 or in between the end of physical memory and 0xC0000000? Do i really need to configure the BAT registers in u boot?
> 	In linux 2.4 kernel, we have ppc_md.setup_io_mappings to map address blocks into the BAT registers... As i observed in the kernel source tree examples, we must map CPM (why?). And what about the other devices A, B and C? How will i setup them in this case and what addresses i can use? Above 0xC0000000 or in between the end of physical memory and 0xC0000000? Is the SDRAM included?
> 
> 	Thanks in advance to all contributions! All of them will be most welcomed!
> 
> 
> 
> 
> 
> Best regards,
> Filipe
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
