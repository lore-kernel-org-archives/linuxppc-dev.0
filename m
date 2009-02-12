Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 6059ADDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 03:35:32 +1100 (EST)
Date: Thu, 12 Feb 2009 11:35:30 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7][RFC] function graph tracer port to PowerPC
In-Reply-To: <20090212011051.265346435@goodmis.org>
Message-ID: <alpine.DEB.1.10.0902121132000.15469@gandalf.stny.rr.com>
References: <20090212011051.265346435@goodmis.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 11 Feb 2009, Steven Rostedt wrote:

> 
> The following set of patches are RFC and not for inclusion
> (unless everyone is fine with them as is).
> 
> This is the port to PowerPC of the function graph tracer that was written
> by Frederic Weisbecker for the x86 architecture.  It is broken up
> into a series of logical steps.
> 
> 1) get generic code ready for other archs
> 2) get PowerPC 64-bit working with just static function tracing
> 3) get PowerPC 64-bit working with dynamic function tracing
> 4) get PowerPC 32-bit working with just static function tracing
> 5) get PowerPC 32-bit working with dynamic function tracing
> 
> (with some clean ups in between)

Ben, if you get some time (no rush really), can you give an acked-by
on each of the PPC patches. The first patch is ftrace generic, so
you can ignore that one.

I'll keep it in the RFC state, until I have an ack from either you or
Paul.

I'm not sure if these changes should go via you or Ingo. I'm thinking 
that, since the first change modifies core ftrace code, I'll send it 
towards tip, since all the rest depends on that first change.

Thanks,

-- Steve
