Return-Path: <jjboor@aimsys.nl>
Received: from smtp04.wanadoo.nl (smtp04.wanadoo.nl [194.134.35.144])
	by ozlabs.org (Postfix) with ESMTP id CCF932BDB3
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2004 04:46:00 +1000 (EST)
In-Reply-To: <20041007173449.GA3540@gate.ebshome.net>
References: <200410071529.12909.g.jaeger@sysgo.com>
	<20041007173449.GA3540@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C3EF3884-188D-11D9-841F-000A95B15278@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Thu, 7 Oct 2004 20:21:54 +0200
To: Gerhard Jaeger <g.jaeger@sysgo.com>
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


On 7-okt-04, at 19:34, Eugene Surovegin wrote:

> On Thu, Oct 07, 2004 at 03:29:12PM +0200, Gerhard Jaeger wrote:
>> maybe the 2.4 series is somewhat outdatet, but nevertheless used in
>> several embedded systems and also with your preemption patches.
>> During some investigations, we found out that the patches found on
>> http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/
>> contain a severe bug, when using the patches on PPC systems.
>
> Yes, it's a known problem with rml preempt patches - DON'T USE THEM
> on PPC. I sent him similar patch _two_ years ago - nothing happened.
> MVL tree is IMHO better place to get preempt stuff for 2.4 - it's
> actually tested and works.

yes, because there are more changes then only the forgotten '{'

Jaap-Jan

>
> Also, I wish -embedded archives were online, this problem was
> discussed there around a year ago as well.
>
> --
> Eugene
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
