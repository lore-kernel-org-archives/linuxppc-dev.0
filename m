Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33603679E2
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 00:37:18 +1000 (EST)
In-Reply-To: <20060425222841.C2D0E353DAC@atlas.denx.de>
References: <20060425222841.C2D0E353DAC@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A8793E99-83C1-4FD9-8735-D2E8F98B3003@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Wed, 26 Apr 2006 09:37:09 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 5:28 PM, Wolfgang Denk wrote:

> In message  
> <DAD4396E-7458-471C-8150-9DDCD396BA63@kernel.crashing.org> you wrote:
>>
>>> No. Remove them from the U-Boot tree. I was never happy to  see   
>>> this
>>> stuff there.
>>
>> Then why did you accept the patches for them?  I'm confused on what
>
> Because I  had  neither  time  nor  nerves  to  discuss  with  kernel
> maintainers how this could be done. Several people asked me again and
> again  to  accept  these  patches  because  they  were  vital for FDT
> support, so I gave in.
>
>> you see as the solution for how to boot an arch/powerpc kernel going
>> forward.
>
> I strongly agree with Dan and Eugene: the kernel should not depend on
> any specific version of a boot loader, and more general not  even  on
> any specific boot loader at all.

I think thats part of the idea with arch/powerpc defining a standard  
mechanism for how a boot loader should pass information to the kernel  
(via a flat device tree).

How would you propose that we handle booting arch/powerpc kernels  
from u-boot going forward? (for new board ports and existing board  
ports).

- kumar
