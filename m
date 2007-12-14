Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C77AFDDF5E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:45:10 +1100 (EST)
Message-Id: <97EB3576-6952-4F36-A243-4EBF981A117F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Li <r64360@freescale.com>
In-Reply-To: <1196764760.2573.10.camel@Guyver>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support
Date: Thu, 13 Dec 2007 23:44:50 -0600
References: <1196764760.2573.10.camel@Guyver>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	kim phillips <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 4, 2007, at 4:39 AM, Li Li wrote:

> Modified based on discussion on list.
>
> 1. Adopt virq_to_hw routine
> 2. Correct a legacy bug
>
> Implements the IPIC MSI as two level interrupt controller.
>
> Signed-off-by: Tony Li <tony.li@freescale.com>

Tony, have you looked at the 85xx/86xx PCIe MSI mechanism?  The 2nd  
level PIC handling seems like its pretty similar between IPIC and  
MPIC.  Would like to see if we could somehow make the code common for  
to handle MSIs from both?

- k
