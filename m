Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29253B7B7A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2009 15:12:57 +1100 (EST)
Subject: Re: [PATCH 3/3] powerpc: perf_event: Hide iseries_check_pending_irqs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20091020035058.GU4808@kryten>
References: <20091018112328.GN4808@kryten> <20091018112406.GO4808@kryten>
	<20091018112429.GP4808@kryten> <20091019072334.GA17960@elte.hu>
	<20091020035058.GU4808@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Oct 2009 13:12:44 +0900
Message-Id: <1256011964.8313.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, paulus@samba.org,
	a.p.zijlstra@chello.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-20 at 14:50 +1100, Anton Blanchard wrote:
> Hi Ingo,
> 
> > Just to confirm - these 3 symbol fixes are for the PowerPC tree, not for 
> > the perf events tree, right? There's nothing perf specific about the 
> > fixes - kgdb, systemtap and other debugging/instrumentation frameworks 
> > will benefit from more precise symbol generation too.
> 
> Yeah, while they were written to fix perf backtrace issues they are
> definitely not perf specific. Hopefully Ben will queue them up in his
> tree for the next merge window :)

Right, I'm overdue for a powerpc-next but with some family issues last
couple of week and KS/JLS this week, it' a bit hard :-)

Ben.
 
