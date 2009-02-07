Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A29FDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 21:08:51 +1100 (EST)
Subject: Re: [PATCH] powerpc: Rework I$/D$ coherency (v2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090207.002214.259050726.davem@davemloft.net>
References: <20090202001035.E1390DDF3D@ozlabs.org>
	<20090207.002214.259050726.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 07 Feb 2009 21:08:16 +1100
Message-Id: <1234001296.31963.65.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-02-07 at 00:22 -0800, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 02 Feb 2009 11:10:24 +1100
> 
> > +/* has to be a macro because of include dependencies */
> > +static inline int is_exec_fault(void)
> > +{
> > +	return current->thread.regs && TRAP(current->thread.regs) == 0x400;
> > +}
> 
> Nice macro :-)

Hehe... was a macro in my original implementation and I turned it back
into an inline later on... missed the comment obviously :-)

I'll fix it, thanks for having a look.

Cheers,
Ben.
