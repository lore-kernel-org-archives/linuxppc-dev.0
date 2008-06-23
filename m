Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B446DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jun 2008 03:00:48 +1000 (EST)
Message-ID: <485FD6AC.6010605@freescale.com>
Date: Mon, 23 Jun 2008 12:00:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Qin, Laigui (GE EntSol, Security)" <laigui.qin@ge.com>
Subject: Re: NAND access fail after MMU enabled when booting linux
References: <A9D89E0D76AFF24B9441851F2AC72D7203E7E23C@BANMLVEM05.e2k.ad.ge.com>
In-Reply-To: <A9D89E0D76AFF24B9441851F2AC72D7203E7E23C@BANMLVEM05.e2k.ad.ge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Qin, Laigui (GE EntSol, Security) wrote:
> I am facing a MMU related problem when porting Linux to my custom board 
> with Coldfire M5445x processor. The observation is that* the nand Bus 
> chip select/WE/RE become 100 times longer than normal when MMU enabled*. 
> I just can not understand this...

Coldfire is m68k; this list is for powerpc.

> Look into my driver codes, I use the virtual address (0xe0000000) 
> applied from ioremap() kernel function.
> 
> 136         /* map physical address */
> 137         this->IO_ADDR_R = this->IO_ADDR_W = ioremap(0x00000000, 1024);
> 138         if (!this->IO_ADDR_R) {
> 139                 printk(KERN_WARNING "ioremap micron NAND @0x00000000 
> failed\n");

Is it really at address zero, or is that where your RAM is?

-Scott
