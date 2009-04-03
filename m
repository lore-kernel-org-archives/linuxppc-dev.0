Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82AD7DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 01:15:51 +1100 (EST)
Message-Id: <3DA386C6-F26A-4929-8609-FE468DF01572@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Keep track of emulated instructions
Date: Fri, 3 Apr 2009 09:15:44 -0500
References: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2009, at 7:08 AM, Geert Uytterhoeven wrote:

> 	Hi Ben, Kumar,
>
> Finally (after ca. 1.5 years), he're an updated version of my patch  
> to keep
> track of emulated instructions.  In the light of Kumar's `Emulate  
> enough of SPE
> instructions to make gcc happy' patch, he probably also wants to  
> keep track of
> the actual runtime overhead.
>
> Changes since last version:
>  - arch/powerpc/kernel/sysfs.c is now compiled on ppc32, so we can  
> provide
>    counters in sysfs on ppc32, too,
>  - WARN_EMULATED() is a no-op if CONFIG_SYSCTL is disabled,
>  - Add warnings for altivec,
>  - Add warnings for recently introduced emulation of vsx and isel
>    instructions.

pretty cool.  Do we think counters should be sysfs or debugfs?

Also it would be nice to be able to zero out the counters.

- k
