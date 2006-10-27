Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8BD7167D98
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Oct 2006 00:29:32 +1000 (EST)
Date: Fri, 27 Oct 2006 17:38:42 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: robin.gilks@tait.co.nz
Subject: Re: Building new FEC code on 8xx with 2.6.17 kernel
Message-ID: <20061027173842.4e53bdd6@vitb.ru.mvista.com>
In-Reply-To: <454163B2.4010308@tait.co.nz>
References: <454163B2.4010308@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 27 Oct 2006 14:41:06 +1300
Robin Gilks <robin.gilks@tait.co.nz> wrote:

> Greetings
> 
> Just having a first stab at building for an 859T based product so I 
> assume I'll be using the new FEC driver. I'm getting two unresolved 
> references as follows:
> 
> drivers/built-in.o: In function 
> `fec_8xx_init':fec_main.c:(.init.text+0x1a40): undefined reference to 
> `fec_8xx_platform_init'
> drivers/built-in.o: In function 
> `fec_8xx_cleanup':fec_main.c:(.exit.text+0x39c): undefined reference to 
> `fec_8xx_platform_cleanup'
> 
> No big deal as I can see an example for the netta platform (whatever 
> that is) that defines these functions and I can hack that to suit my 
> hardware - what I can't find is where CONFIG_NETTA is defined. I can't 
> find it in any Kconfig file, and I want to use the same mechanism for 
> selecting my platform.
> 
> Any ideas? (or is FEC still broken on CPM1 processors)
> 

Please use fs_enet driver (drivers/fs_enet). You can find the reference for platform code at
say arch/ppc/platforms/mpc885_setup.c

-- 
Sincerely, 
Vitaly
