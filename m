Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3A80DE2FD
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 23:21:01 +1000 (EST)
Message-Id: <1492DA11-D49C-492A-9085-3B5A7A569245@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Marc <jmarc007@yahoo.com>
In-Reply-To: <624875.78682.qm@web46013.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: USB on MPC8641D
Date: Thu, 17 Apr 2008 08:20:55 -0500
References: <624875.78682.qm@web46013.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2008, at 3:36 AM, John Marc wrote:
> Hi
> I Have the kernel patches , but no one for the USB.
> The changes for the USB are integrated in the Kernel.
> I am currently looking into the linux BSP for usb
> changes , but unfortunately don't find any major
> chages.
>
> MPC8641 board have one EHCI controller and 3 OHCI
> conroller.
>
> As I am also new to USB , it would be great help, if
> someone give me any idea about the changes in new
> MPC8641 BSP ?
>
> Does freescale fix the PCI Express issue , that makes
> USB works.
>
> I have lots of hope with this forum :-)
>
>
> With Regards
> John

This forum is about the open source kernel and not BSPs kernels from  
Freescale or any other provider.

Have you tried a 2.6.24 or 2.6.25 open source kernel for the 8641 and  
see if it works w/regards to USB.  If not we can help try and figure  
out why not.

There have been a number of fixes made to PCIe support on 8641 that  
are in the 2.6.24 kernel, I'm guessing some of those might address  
whatever issue you're seeing with USB.

- k
