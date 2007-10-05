Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC06EDDE01
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 10:57:46 +1000 (EST)
In-Reply-To: <4705691A.9020509@freescale.com>
References: <4705691A.9020509@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1A8BFD27-0CBF-48CA-999D-3BD3D2160979@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: include/asm/cpm2.h:14:21: error: asm/cpm.h: No such file or
	directory
Date: Thu, 4 Oct 2007 19:57:30 -0500
To: Timur Tabi <timur@freescale.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 4, 2007, at 5:28 PM, Timur Tabi wrote:

> Kumar, this is what I get when I compile your 2.6.24 branch for the  
> 8610:
>
>   CC      arch/powerpc/sysdev/fsl_soc.o
> In file included from arch/powerpc/sysdev/fsl_soc.c:40:
> include/asm/cpm2.h:14:21: error: asm/cpm.h: No such file or directory
> make[1]: *** [arch/powerpc/sysdev/fsl_soc.o] Error 1
> make: *** [arch/powerpc/sysdev] Error 2
>
> Commenting out the "#include <asm/cpm.h>" in cpm2.h makes the  
> compilation failure go away, but I don't know if that's the proper  
> fix, since the 8610 doesn't have a CPM.

Scott mentioned this and I've fixed it in my tree.

- k
