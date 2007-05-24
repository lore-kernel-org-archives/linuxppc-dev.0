Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id F0960DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 10:02:38 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 23 May 2007 17:02:37 -0700
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Add Marvell mv64x60 udbg putc/getc functions
Message-ID: <20070524000237.GB11608@xyzzy.farnsworth.org>
References: <20070523220518.GA2312@xyzzy.farnsworth.org>
	<20070523232745.GA4611@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070523232745.GA4611@lixom.net>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 23, 2007 at 06:27:45PM -0500, Olof Johansson wrote:
> On Wed, May 23, 2007 at 03:05:18PM -0700, Dale Farnsworth wrote:
> 
> >  arch/powerpc/platforms/embedded6xx/prpmc2800.c |    1 
> >  arch/powerpc/sysdev/Makefile                   |    3 
> >  arch/powerpc/sysdev/mv64x60.h                  |    1 
> >  arch/powerpc/sysdev/mv64x60_udbg.c             |  152 +++++++++++++++
> >  4 files changed, 156 insertions(+), 1 deletion(-)
> 
> Is there a reason you're not putting it with the other udbg code, and
> not naming it with the same scheme (kernel/udbg_<xxx>)?

Not really.  I just put it with some other mv64x60 code.

> Or maybe we should just move the udbg_16550 code to sysdev instead, it's
> roots are from ppc64 where we didn't have sysdev.

Shrug.

-Dale
