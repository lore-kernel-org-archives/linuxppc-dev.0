Return-Path: <fweisbec@gmail.com>
Received: from mail-bw0-f168.google.com (mail-bw0-f168.google.com
	[209.85.218.168]) by ozlabs.org (Postfix) with ESMTP id 1A3BDDDDB8
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 15:08:36 +1100 (EST)
Received: by bwz12 with SMTP id 12so1325172bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 20:08:33 -0800 (PST)
Date: Thu, 12 Feb 2009 05:08:30 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/7][RFC] function graph tracer port to PowerPC
Message-ID: <20090212040829.GB4809@nowhere>
References: <20090212011051.265346435@goodmis.org>
	<20090212015503.GA4697@nowhere>
	<alpine.DEB.1.10.0902112116340.13595@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0902112116340.13595@gandalf.stny.rr.com>
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

On Wed, Feb 11, 2009 at 09:16:57PM -0500, Steven Rostedt wrote:
> 
> On Thu, 12 Feb 2009, Frederic Weisbecker wrote:
> 
> > On Wed, Feb 11, 2009 at 08:10:51PM -0500, Steven Rostedt wrote:
> > > 
> > > The following set of patches are RFC and not for inclusion
> > > (unless everyone is fine with them as is).
> > > 
> > > This is the port to PowerPC of the function graph tracer that was written
> > > by Frederic Weisbecker for the x86 architecture.  It is broken up
> > > into a series of logical steps.
> > > 
> > > 1) get generic code ready for other archs
> > > 2) get PowerPC 64-bit working with just static function tracing
> > > 3) get PowerPC 64-bit working with dynamic function tracing
> > > 4) get PowerPC 32-bit working with just static function tracing
> > > 5) get PowerPC 32-bit working with dynamic function tracing
> > > 
> > > (with some clean ups in between)
> > > 
> > 
> > 
> > Thanks a lot Steven!
> > I'm sad to not having a Power Pc to test it...
> 
> If you had a PowerPC, I doubt I would have been the one to port it ;-)


Especially since you already implemented ftrace on PowerPc :)
I will acquire an Arm board soon to adapt function graph on Arm...
 
> -- Steve
> 
