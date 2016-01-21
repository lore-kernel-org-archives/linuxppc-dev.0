Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDFE61A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 23:54:57 +1100 (AEDT)
Message-ID: <1453380891.28627.3.camel@ellerman.id.au>
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jikos@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Torsten Duwe <duwe@lst.de>, Steven
 Rostedt <rostedt@goodmis.org>, Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Thu, 21 Jan 2016 23:54:51 +1100
In-Reply-To: <alpine.LNX.2.00.1601211032430.21446@cbobk.fhfr.pm>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20160106141730.GL3178@pathway.suse.cz>
 <1453269803.14751.10.camel@ellerman.id.au>
 <alpine.LNX.2.00.1601211032430.21446@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-21 at 10:33 +0100, Jiri Kosina wrote:
> On Wed, 20 Jan 2016, Michael Ellerman wrote:
> 
> > For me the series doesn't even boot, even with livepatching disabled.
> 
> Could you please post config and dmesg from that non-booting kernel?

Sorry been busy.

There is no dmesg :)

It gets stuck in early_setup() before the console is even found.

I'll try with Petr's config and see if that helps.

Also I'm using gcc 6.0 built from mainline just last week, and binutils
similarly. So possibly that is part of the problem.

cheers
