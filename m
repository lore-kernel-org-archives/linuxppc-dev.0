Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BD94B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 17:59:45 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix call to flush_ptrace_hw_breakpoint()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prasad@linux.vnet.ibm.com
In-Reply-To: <20110207045230.GB4287@in.ibm.com>
References: <1297032853.14982.3.camel@pasglop>
	<20110207025643.GA12223@in.ibm.com> <1297048239.14982.29.camel@pasglop>
	<20110207045230.GB4287@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 16:13:37 +1100
Message-ID: <1297055617.14982.59.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Kleikamp <shaggy@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-07 at 10:22 +0530, K.Prasad wrote:
> Okay! Another wrapper of "#ifndef CONFIG_HAVE_HW_BREAKPOINT" around
> the
> definition of 'set_debug_reg_defaults'.

Can you send a patch ?

> There's indeed too much sprinkling of #ifdefs in the code, but most of
> it would go away when the BookE code also uses the generic
> hw-breakpoint interfaces. 

What's your status for those patches ?

> Given the advanced debug features that BookE supports, it's
> unfortunately not that straight-forward (needs additions to generic
> hw-breakpoint infrastructure).

Might want to move a lot of that code to a separate set of files maybe
and just call a single hook from the various process.c locations ?

Cheers,
Ben.
