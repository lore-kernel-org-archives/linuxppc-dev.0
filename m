Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 261F7DDF77
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 05:45:57 +1000 (EST)
Date: Tue, 29 Apr 2008 22:45:17 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>, paulus@samba.org
Subject: Re: 2.6.25: pmac_newworld undefined
Message-ID: <20080429194517.GC2898@cs181133002.pp.htv.fi>
References: <alpine.DEB.1.10.0804271951190.11017@sheep.housecafe.de>
	<20080428042044.GX20457@bakeyournoodle.com>
	<20080428193324.GC13400@uranus.ravnborg.org>
	<20080429133514.GA30524@cs181133002.pp.htv.fi>
	<20080429191753.GA32685@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080429191753.GA32685@uranus.ravnborg.org>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 09:17:53PM +0200, Sam Ravnborg wrote:
>...
> So something like:
> 
> config PPC32_NVRAM
> 	bool
> 	depends on NVRAM
> 
> obj-$(CONFIG_PPC32_NVRAM) += nvram.o
> obj-$(CONFIG_NVRAM)       += nvram.o
> 
> Or did you have another solution in mind?

I start to understand the problem, and I'm currently wondering why 
powerpc uses CONFIG_NVRAM although the code CONFIG_NVRAM enables on 
other platforms is not enabled on powerpc.

Can we rename it and move drivers/char/generic_nvram.c under 
arch/powerpc/ ?

Can some powerpc person bring some background what's going on and why 
it's this way?

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
