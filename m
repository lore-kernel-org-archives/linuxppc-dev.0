Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Oct 2009 14:50:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/3] powerpc: perf_event: Hide iseries_check_pending_irqs
Message-ID: <20091020035058.GU4808@kryten>
References: <20091018112328.GN4808@kryten> <20091018112406.GO4808@kryten>
	<20091018112429.GP4808@kryten> <20091019072334.GA17960@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091019072334.GA17960@elte.hu>
Cc: paulus@samba.org, a.p.zijlstra@chello.nl, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Ingo,

> Just to confirm - these 3 symbol fixes are for the PowerPC tree, not for 
> the perf events tree, right? There's nothing perf specific about the 
> fixes - kgdb, systemtap and other debugging/instrumentation frameworks 
> will benefit from more precise symbol generation too.

Yeah, while they were written to fix perf backtrace issues they are
definitely not perf specific. Hopefully Ben will queue them up in his
tree for the next merge window :)

Anton
