Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0F8DDDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 01:58:55 +1100 (EST)
Date: Thu, 15 Mar 2007 09:55:34 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: fix invalid pointer usage in ucc_slow_init()
In-Reply-To: <1173970133624-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0703150955220.23053@localhost.localdomain>
References: <1173970133624-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 Mar 2007, Timur Tabi wrote:

> In two places, ucc_slow_init() passes a physical address instead of the
> virtual address to functions that were expecting the latter, causing a kernel
> panic.  us_info->regs contains the physical address of the UCC register set.
> The registers are ioremap'd to kernel space, and the virtual pointers are
> stored in us_regs.  The code was using us_info->regs when it should have been
> using us_regs.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

applied.

- k
