Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4831FDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 02:23:43 +1100 (EST)
Message-Id: <901A2F2F-D072-4F03-AA39-9AB6A56EA635@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Li <r64360@freescale.com>
In-Reply-To: <1199272605.22416.8.camel@Guyver>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
Date: Wed, 2 Jan 2008 09:23:35 -0600
References: <1199272605.22416.8.camel@Guyver>
Cc: Wood Scott <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	kim phillips <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 2, 2008, at 5:16 AM, Li Li wrote:

> * The MPC837x PCIE controller hardware resources and SerDes are  
> initiated in u-boot.
> * Merge the MPC837x PCIE code into arch/powerpc/sysdev/fsl_pci.c
> * The MPC837x PCIE controller`s configure address bit field is uniqe:
> 	bus number:		bits 31-24
> 	device number:		bits 23-19
> 	function number:	bits 18-16
> 	ext reg number:		bits 11-8
> 	reg number:		bits 7-2
> * Add mpc837x_exclude_device to fixup a controller bug.

what is the bug that is being worked around?

- k
