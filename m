Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C868DDF1D
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 10:05:04 +1000 (EST)
In-Reply-To: <A99C864E-5D7A-4610-BA75-A3B9CF54D575@kernel.crashing.org>
References: <20070612163016.253915076@arndb.de>
	<200706170214.11247.arnd@arndb.de>
	<4E0AC3E6-98F8-40BD-BA85-60766E097E4A@kernel.crashing.org>
	<200706180109.11482.arnd@arndb.de>
	<A99C864E-5D7A-4610-BA75-A3B9CF54D575@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FDDC4B07-B98C-4395-A3E1-E167B7C13EF4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Mon, 18 Jun 2007 19:05:36 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 17, 2007, at 6:09 PM, Arnd Bergmann wrote:

> On Sunday 17 June 2007, Kumar Gala wrote:
>> I commented on some minor nits with the patches.  I'm probably ok
>> with patches 1-7 going in.  I'm not ready for 8 at this point, we
>> need to do more proper cleanup to get 85xx/cpm2 support into a
>> multiplatforms single kernel state.
>
> Ok, makes sense. I've fixed up the other patches according to
> your comments (did not change 8xx stuff though) and pushed
> it out to
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6 powerpc- 
> kconfig
>
> Paul, please pull from there, I'll remember not to try messing with
> 32 bit in the future but wanted to get this in after spending so
> much work on it.

Paul,

I'll pull these into my tree with a bunch of other ppc32/embedded  
related patches for you to pull all at once since I've got other  
changes that will depend on them.

- k
