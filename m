Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F1F2DE25D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 17:07:18 +1000 (EST)
Message-Id: <0C6DE62B-F58F-4E61-B7AC-56EC1D1DCAE7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Marc <jmarc007@yahoo.com>
In-Reply-To: <453663.50949.qm@web46010.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: USB on MPC8641D
Date: Thu, 17 Apr 2008 02:07:13 -0500
References: <453663.50949.qm@web46010.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2008, at 1:48 PM, John Marc wrote:
> Hi Everybody,
> I find this forum very much useful for the people who are working  
> with powerpc's , and i am the one of them.Actually one more thing  
> that make me to join this forum is my interest towards the Freescale  
> MPC8641d board :-). I found that Freescale recently uploaded the  
> linux BSP for MPC8641D board. One of the thing new in this BSP is  
> USB driver.
>
> At Ozlabs I found various patches for MPC8641D board,Most of then  
> are regarding the PCI Express fixes, Some patches of ULI1575 chip,  
> but my main concern is USB.
>
> Can amyone help me out to find , what are the changes that freescale  
> does for the USB drivers. I tried to search a lot for USB patch, but  
> my bad luck , i don't find anything.
>
> It would be a great help if anyone help me out to find what are the  
> changes that freescale does for USB driver.

There shouldn't be any, but if you have a BSP from Freescale you  
should have patches to that kernel as well.

We should be using the stock USB driver for the ULI chipset.  (I  
forget if its ehci/ohci/uchi).

- k
