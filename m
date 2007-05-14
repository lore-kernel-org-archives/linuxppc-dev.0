Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0627DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 23:59:46 +1000 (EST)
In-Reply-To: <1179116138.18580.2.camel@shinybook.infradead.org>
References: <20070514135033.07c1b840.sfr@canb.auug.org.au>
	<1AF532FF-A994-47AF-9394-5DFFC6C8FDA1@kernel.crashing.org>
	<1179116138.18580.2.camel@shinybook.infradead.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B31879C1-6E28-45F5-8253-466785183E41@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Wire up some more syscalls
Date: Mon, 14 May 2007 08:58:47 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org,
	Arnd Bergmann <arnd@arndb.de>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 13, 2007, at 11:15 PM, David Woodhouse wrote:

> On Sun, 2007-05-13 at 22:55 -0500, Kumar Gala wrote:
>> Just out of interest, what makes a syscall COMPAT_SYS_SPU vs
>> SYSCALL_SPU?
>
> It's the same as the difference between COMPAT_SYS and SYSCALL.
>
> The _SPU suffix just means that the SPU can use the (native) syscall.
>
> The COMPAT_ prefix means that there's a compat function to call  
> instead
> of calling the native one directly for 32-bit code.


The COMPAT I get, but what does it mean to be able to use a syscall  
on SPU natively?  When wouldn't you be able to do this?

- k
