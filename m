Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 32B1DDDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 03:31:45 +1100 (EST)
Date: Thu, 12 Feb 2009 11:31:44 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 0/7][RFC] function graph tracer port to PowerPC
In-Reply-To: <20090212015503.GA4697@nowhere>
Message-ID: <alpine.DEB.1.10.0902121131150.15469@gandalf.stny.rr.com>
References: <20090212011051.265346435@goodmis.org>
	<20090212015503.GA4697@nowhere>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 12 Feb 2009, Frederic Weisbecker wrote:

> On Wed, Feb 11, 2009 at 08:10:51PM -0500, Steven Rostedt wrote:
> > 
> > The following set of patches are RFC and not for inclusion
> > (unless everyone is fine with them as is).
> > 
> > This is the port to PowerPC of the function graph tracer that was written
> > by Frederic Weisbecker for the x86 architecture.  It is broken up
> > into a series of logical steps.
> > 
> > 1) get generic code ready for other archs
> > 2) get PowerPC 64-bit working with just static function tracing
> > 3) get PowerPC 64-bit working with dynamic function tracing
> > 4) get PowerPC 32-bit working with just static function tracing
> > 5) get PowerPC 32-bit working with dynamic function tracing
> > 
> > (with some clean ups in between)
> > 
> 
> 
> Thanks a lot Steven!
> I'm sad to not having a Power Pc to test it...

BTW, Can I count that as an Acked-by: for the first patch. Since the first 
patch does modify your code.

-- Steve
