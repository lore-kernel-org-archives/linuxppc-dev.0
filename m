Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F2DCD2BDA1
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2004 04:35:54 +1000 (EST)
Date: Thu, 7 Oct 2004 11:35:51 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Message-ID: <20041007183551.GA22982@gate.ebshome.net>
References: <200410071529.12909.g.jaeger@sysgo.com>
	<20041007173449.GA3540@gate.ebshome.net>
	<C3EF3884-188D-11D9-841F-000A95B15278@aimsys.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C3EF3884-188D-11D9-841F-000A95B15278@aimsys.nl>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [BUG][PPC32] Preemption patch for 2.4 Kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 07, 2004 at 08:21:54PM +0200, Jaap-Jan Boor wrote:
> 
> On 7-okt-04, at 19:34, Eugene Surovegin wrote:
> 
> >On Thu, Oct 07, 2004 at 03:29:12PM +0200, Gerhard Jaeger wrote:
> >>maybe the 2.4 series is somewhat outdatet, but nevertheless used in
> >>several embedded systems and also with your preemption patches.
> >>During some investigations, we found out that the patches found on
> >>http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/
> >>contain a severe bug, when using the patches on PPC systems.
> >
> >Yes, it's a known problem with rml preempt patches - DON'T USE THEM
> >on PPC. I sent him similar patch _two_ years ago - nothing happened.
> >MVL tree is IMHO better place to get preempt stuff for 2.4 - it's
> >actually tested and works.
> 
> yes, because there are more changes then only the forgotten '{'
> 

You're right, there were other (not so obvious) problems which rml 
patch (like preempt_enable_no_resched() in 
irq.c::preempt_intercept()), maybe others I don't remember now)...

--
Eugene
