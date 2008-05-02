Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92453DDE41
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 07:31:35 +1000 (EST)
Message-Id: <549B96DB-87C0-4219-B0F3-2A23AA95DF48@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1f2a22ddd60d37e6e7dc1048feb6d0a4@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
Date: Fri, 2 May 2008 16:31:30 -0500
References: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
	<1f2a22ddd60d37e6e7dc1048feb6d0a4@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 12:33 PM, Segher Boessenkool wrote:

>> If someone using cutting edge toolchains for ppc64 could test and  
>> make
>> sure if we enable CONFIG_CC_OPTIMIZE_FOR_SIZE things work that  
>> would be
>> nice.
>
> Current linus tree + some more stuff + this patch, ppc64_defconfig,
> powerpc64-linux-gcc (GCC) 4.4.0 20080429 (experimental), builds just
> fine.  CONFIG_CC_OPTIMIZE_FOR_SIZE=y.  Need any more test / more info?

I don't think the gcc guys have accepted (or committed) the patch I  
was referencing.  Once it has been we should retest and see what  
happens.

- k
