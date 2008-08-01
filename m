Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 039EADDFEA
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 06:38:21 +1000 (EST)
Date: Sat, 2 Aug 2008 00:38:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/8] powerpc: add the ability for a classic ppc kernel
	to be loaded at 32M
Message-ID: <20080801203819.GA27753@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
	<20080801141420.GD1161@polina.dev.rtsoft.ru>
	<20080801184952.GA25225@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080801184952.GA25225@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 01, 2008 at 01:49:52PM -0500, Scott Wood wrote:
> On Fri, Aug 01, 2008 at 06:14:20PM +0400, Anton Vorontsov wrote:
> > From: Dale Farnsworth <dale@farnsworth.org>
> > 
> > Add the ability for a classic ppc kernel to be loaded at an address
> > of 32MB.  This done by fixing a few places that assume we are loaded
> > at address 0, and by changing several uses of KERNELBASE to use
> > PAGE_OFFSET, instead.
> 
> What do you do about the exception vectors?

Making a trampoline code in place of exception vectors. See this patch:

[PATCH 8/8] powerpc: last bits to support kdump on ppc32

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
