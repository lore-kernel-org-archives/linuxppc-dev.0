Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id A0DAF67A86
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 01:18:11 +1100 (EST)
Date: Thu, 24 Feb 2005 07:18:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James Chapman <jchapman@katalix.com>
Message-ID: <20050224141809.GP345@smtp.west.cox.net>
References: <421CEC19.2010703@katalix.com>
	<20050223222534.GM345@smtp.west.cox.net>
	<421D97FE.4080100@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421D97FE.4080100@katalix.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PATCH: add ppc PVR register values for 7447A and 7457 CPUs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 09:01:50AM +0000, James Chapman wrote:
> Tom Rini wrote:
> 
> >On Wed, Feb 23, 2005 at 08:48:25PM +0000, James Chapman wrote:
> >
> >>Signed-off-by: James Chapman <jchapman@katalix.com>
> >>
> >>Trivial patch to add 7447A and 7457 CPU defs.
> >
> >
> >Why?  Most of the PVR definitions here can be removed (*muttering about
> >85xx ones being added).
> >
> 
> I'm in the process of submitting a patch for a new board (Radstone
> PPC7D). Since other boards test CPU type using definitions in this file,
> I was trying to be consistent.
> 
> If the community don't think those definitions are useful, I'll just
> move the ones I need into my board support stuff.

Is there something you can't get from cur_cpu_spec[0] ?  That's why all
of the PVR definitions _should_ be unneeded now.

-- 
Tom Rini
http://gate.crashing.org/~trini/
