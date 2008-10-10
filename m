Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43C27DDF26
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 00:29:34 +1100 (EST)
Message-Id: <488B87CB-8998-4A29-903A-4952B3A806AB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1222181221-13425-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: remove support for bootmem-allocated memory for
	the DIU driver
Date: Fri, 10 Oct 2008 08:28:01 -0500
References: <1222181221-13425-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 23, 2008, at 9:47 AM, Timur Tabi wrote:

> Early versions of the Freescale DIU framebuffer driver depended on a  
> bootmem
> allocation of memory for the video buffer.  The need for this  
> feature was
> removed in commit 6b51d51a, so now we can remove the platform- 
> specific code
> that allocated that memory.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch is for 2.6.28.
>
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 -
> arch/powerpc/sysdev/fsl_soc.c              |   38  
> +---------------------------
> arch/powerpc/sysdev/fsl_soc.h              |    8 ------
> 3 files changed, 1 insertions(+), 46 deletions(-)

applied.

- k
