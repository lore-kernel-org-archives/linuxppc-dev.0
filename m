Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6800067C48
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 08:17:11 +1100 (EST)
In-Reply-To: <BAY102-F634C51A5AEEB25090456BA9FD0@phx.gbl>
References: <BAY102-F634C51A5AEEB25090456BA9FD0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C508D5D4-125D-47FD-81D2-2DE6545A240F@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Booting without Uboot on 8548E
Date: Mon, 6 Nov 2006 15:16:55 -0600
To: M Ptich <ptich@hotmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 4, 2006, at 03:28, M Ptich wrote:

>> You should seriously think about porting
>> over to arch/powerpc instead.
>
> 8548E is E500v2 core. Our Kernel is from Freescale, it is using  
> arch/ppc. I
> am not sure how well (if at all) E500 is supported in the arch/ 
> powerpc from
> the FSF ditribution.


The 8548 is supported in arch/powerpc as of 2.6.18.

But moving to arch/powerpc (while a good idea) is not going to solve  
your problems.  There are bound to be a large number of things the  
kernel expects to have done for it by the firmware.  In arch/powerpc,  
the 8548 kernel expects PCI to be set up, for instance (We plan to  
fix that, but it involves porting some code that only exists in arch/ 
ppc).

Andy
