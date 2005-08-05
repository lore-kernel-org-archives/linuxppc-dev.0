Return-Path: <aris@cathedrallabs.org>
Received: from ivoti.terra.com.br (ivoti.terra.com.br [200.154.55.63])
	by ozlabs.org (Postfix) with ESMTP id 0C3FE67EF1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 03:20:33 +1000 (EST)
Received: from loncoche.terra.com.br (loncoche.terra.com.br [200.176.10.196])
	by ivoti.terra.com.br (Postfix) with ESMTP id 8CF279DBC1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 13:26:30 -0300 (BRT)
Date: Fri, 5 Aug 2005 13:26:17 -0300
From: aris@cathedrallabs.org
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
Message-ID: <20050805162617.GA8433@oops.ghostprotocols.net>
References: <8E342283C2100540AAC5D103097054776F87A9@rcexc.racoms.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8E342283C2100540AAC5D103097054776F87A9@rcexc.racoms.loc>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885ADS and 2.6.13-rc5 - nogo ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>  Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:348
>  Call trace:
>   [c0005b10] dump_stack+0x18/0x28
>   [c0003c60] check_bug_trap+0x84/0xac
>   [c0003de8] ProgramCheckException+0x160/0x1a0
>   [c0003260] ret_from_except_full+0x0/0x4c
>   [c01a9f84] dma_alloc_init+0x44/0xa0
>   [c01a66a4] do_initcalls+0x54/0xfc
>   [c0002260] init+0x2c/0xf4
>   [c000533c] kernel_thread+0x44/0x60
>  NET: Registered protocol family 16
>  JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
>  Serial: CPM driver $Revision: 0.01 $
>  ttyCPM0 at MMIO 0xff000a80 (irq = 20) is a CPM UART
>  ttyCPM1 at MMIO 0xff000a90 (irq = 19) is a CPM UART
just out of curiosity, try changing CONSISTENT_START to 0xe0000000

--
Aristeu
