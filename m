Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7576F67B8B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 06:48:34 +1000 (EST)
In-Reply-To: <44BE9268.9040806@freescale.com>
References: <44B7857A.2060101@freescale.com>	<B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>	<a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>	<A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
	<1153166894.4459.4.camel@basalt.austin.ibm.com>
	<44BE9268.9040806@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1A4E0887-1D6F-4D32-BEDE-7125C36029D4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Wed, 19 Jul 2006 15:48:49 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 19, 2006, at 3:13 PM, Timur Tabi wrote:

> Hollis Blanchard wrote:
>
>> Seems to me that it's far better to have init code in the kernel than
>> firmware. For one example, look at the x86 video card init problem
>> PowerPC Linux has. It's also far easier to fix/deploy Linux code than
>> firmware code, as Li observed, and on top of that it's less work for
>> non-UBoot firmwares in the future.
>
> I also agree 100%.  The boot loader should only be required to  
> initialize whatever hardware it uses.  The kernel should be  
> required to initialize whatever hardware it supports.  The kernel  
> should not assume that USB or PCI or whatever has already been  
> initialized by the boot loader.  This doesn't happen on x86, so we  
> should it happen on PPC?

Let's not drag what x86 does as a good or bad example of anything :)

- k
