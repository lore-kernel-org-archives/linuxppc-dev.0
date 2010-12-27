Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 923F1B70A3
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Dec 2010 08:39:02 +1100 (EST)
Subject: Re: [PATCH][GIT PULL] powerpc64/tracing: Add frame buffer to calls
	of trace_hardirqs_on/off
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1293311043.22802.434.camel@gandalf.stny.rr.com>
References: <1293169566.22802.420.camel@gandalf.stny.rr.com>
	<1293225065.16694.796.camel@pasglop>
	<1293311043.22802.434.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Dec 2010 08:38:37 +1100
Message-ID: <1293485917.16694.821.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joerg Sommer <joerg@alea.gnuu.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-12-25 at 16:04 -0500, Steven Rostedt wrote:
> 
> Note, when CONFIG_IRQSOFF_TRACE is set, there's already a bit of
> overhead :-)
> 
> Anyway, I'll have to take a look at how the frame pointer is set up.
> Or
> we could also set up all stacks coming into the kernel to have a
> "dummy"
> frame pointer that wont hurt anything if we index into it.
> 
> Anyway, I'm off till the new year, so I'll worry about it then ;-)

Right, might be simpler to just make them loop back onto themselves or
something like that. I can have a look too if I get a chance.

Cheers,
Ben.
