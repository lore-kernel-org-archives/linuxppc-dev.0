Return-Path: <SRS0+82eb8e4b0001a5351ca7+1359+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85E89DDE1F
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 14:15:48 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Wire up some more syscalls
From: David Woodhouse <dwmw2@infradead.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1AF532FF-A994-47AF-9394-5DFFC6C8FDA1@kernel.crashing.org>
References: <20070514135033.07c1b840.sfr@canb.auug.org.au>
	<1AF532FF-A994-47AF-9394-5DFFC6C8FDA1@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 14 May 2007 12:15:37 +0800
Message-Id: <1179116138.18580.2.camel@shinybook.infradead.org>
Mime-Version: 1.0
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

On Sun, 2007-05-13 at 22:55 -0500, Kumar Gala wrote:
> Just out of interest, what makes a syscall COMPAT_SYS_SPU vs  
> SYSCALL_SPU?

It's the same as the difference between COMPAT_SYS and SYSCALL.

The _SPU suffix just means that the SPU can use the (native) syscall. 

The COMPAT_ prefix means that there's a compat function to call instead
of calling the native one directly for 32-bit code.

-- 
dwmw2
