Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F7FCDDEBD
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 23:13:52 +1000 (EST)
In-Reply-To: <12253307.post@talk.nabble.com>
References: <12253307.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BFF367AA-0AF7-4C91-A66B-8DB1779BB58C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Regarding PCIExpress Problem in MPC8641D
Date: Tue, 21 Aug 2007 08:15:50 -0500
To: sivaji <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2007, at 7:09 AM, sivaji wrote:

>
> Hai,
>
> Currently I am involved in the testing of a MPC8641D based board  
> designed by
> us. We have planned to test the PCI Express interface through a  
> back to back
> interface, host being mpc8641d and target is mpc8548.
>
> When trying a target DMA transaction we are not able to access the  
> host
> memory using pci Express bus. We are facingDMA Transfer Error.  
> Without DMA
> we are able to access the host memory from the target and target  
> memory from
> the host.
>
>
> The processor rev number is 2.0. The external irq[0-3] are pulled  
> down and
> the polarity is active low and it is level sensitive.
>
> Memory base address : 0x80000000 size:512MB
> I/O base address    : 0xe2000000 size:16MB.
> Kernel Version	    : 2.6.21

I suggest upgrading to 2.6.23-rc3.  There are a number of PCIe  
related fixes that have gone in.

- k
