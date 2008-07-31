Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0CC39DE102
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 05:04:11 +1000 (EST)
Message-Id: <E4D699C2-07A8-42FF-A863-5595099CEC4D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0807311345380.8012@blarg.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc/mm: Implement _PAGE_SPECIAL & pte_special() for
	32-bit
Date: Thu, 31 Jul 2008 13:50:28 -0500
References: <Pine.LNX.4.64.0807311345380.8012@blarg.am.freescale.net>
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 31, 2008, at 1:48 PM, Kumar Gala wrote:

> Implement _PAGE_SPECIAL and pte_special() for 32-bit powerpc. This  
> bit will
> be used by the fast get_user_pages() to differenciate PTEs that  
> correspond
> to a valid struct page from special mappings that don't such as IO  
> mappings
> obtained via io_remap_pfn_ranges().
>
> We currently only implement this on sub-arch that support SMP or  
> will so
> in the future (6xx, 44x, FSL-BookE) and not (8xx, 40x).
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> Nick, do you forsee using _PAGE_SPECIAL for other applications that  
> would
> be of interested to non-SMP hw?
>
> We can look at adding it into 8xx and 40x, but was being lazy as I  
> assume
> there is no point.
>
> - k

Josh,

Can you test this on 44x for me.

thanks

- k
