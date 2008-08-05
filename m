Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 4D9A2DDDE6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 23:13:23 +1000 (EST)
Date: Tue, 5 Aug 2008 15:10:55 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 64-bit build failure without hugetlbfs
Message-ID: <20080805151055.5e2cdc21@bull.net>
In-Reply-To: <1217936390.3603.34.camel@johannes.berg>
References: <1217936390.3603.34.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 05 Aug 2008 13:39:49 +0200 Johannes Berg <johannes@sipsolutions.net> wrote:

>   LD      vmlinux.o
> mm/built-in.o: In function `.arch_get_unmapped_area_topdown':
> (.text+0x1d084): multiple definition of `.arch_get_unmapped_area_topdown'
> arch/powerpc/mm/built-in.o:(.text+0x7240): first defined here
> mm/built-in.o: In function `arch_get_unmapped_area_topdown':
> (.opd+0x2730): multiple definition of `arch_get_unmapped_area_topdown'
> arch/powerpc/mm/built-in.o:(.opd+0x918): first defined here
> mm/built-in.o: In function `.arch_get_unmapped_area':
> (.text+0x1ce3c): multiple definition of `.arch_get_unmapped_area'
> arch/powerpc/mm/built-in.o:(.text+0x72b8): first defined here
> mm/built-in.o: In function `arch_get_unmapped_area':
> (.opd+0x2718): multiple definition of `arch_get_unmapped_area'
> arch/powerpc/mm/built-in.o:(.opd+0x930): first defined here
> make: *** [vmlinux.o] Error 1
> 
> enabling hugetlbfs cures it.
> 
> johannes

  Or disabling CONFIG_PPC_64K_PAGES if you do not want to enable hugetlbfs...

  Sebastien.
