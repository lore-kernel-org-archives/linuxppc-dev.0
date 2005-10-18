Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F5D5685BB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 04:57:42 +1000 (EST)
Date: Tue, 18 Oct 2005 12:24:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051018142411.GA14065@logos.cnet>
References: <434BC424.50700@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <434BC424.50700@ru.mvista.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: ppc_sys fixes for 8xx and 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

> This patch fixes a numbers of issues regarding to that both 8xx and 82xx 
> began to use ppc_sys model:
> 	- Platform is now identified by default deviceless SOC, if no 
> BOARD_CHIP_NAME is specified in the bard-specific header. For the list 
> of supported names refer to (arch/ppc/syslib/) mpc8xx_sys.c and 
> mpc82xx_sys.c for 8xx and 82xx respectively.
> 	- Fixed a bug in identification by name - if the name was not found, 
> 	it returned -1 instead of default deviceless ppc_spec.
> 	- fixed devices amount in the 8xx platform system descriptions

Patch looks good. 

For 8xx, I was wondering if the PARTNUM field of the IMMR 
(section 10.4.1 of MPC860UM.pdf) does have meaningful 
information which could be used to identify the CPU.
