Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E6BBDDEEB
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 11:37:34 +1100 (EST)
Message-Id: <3E0C2128-A7CE-4144-925C-F3EBA7B2F2E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <11963675973785-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: powerpc: fix guts_set_dmacr() and add guts_set_pmuxcr_dma() to
	immap_86xx.h
Date: Thu, 29 Nov 2007 18:37:25 -0600
References: <11963675973785-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 29, 2007, at 2:19 PM, Timur Tabi wrote:

> Updated guts_set_dmacr() to enumerate the DMA controllers at 0,  
> instead of 1,
> so that it now matches other related functions.  Added function
> guts_set_pmuxcr_dma() to set the external DMA control bits in the  
> PMUXCR
> register of the global utilities structure.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Changing the behavior of guts_set_dmacr() is okay because no one  
> uses that
> function yet.
>
> This patch is for Kumar's for-2.6.25 branch.

applied.

- k
