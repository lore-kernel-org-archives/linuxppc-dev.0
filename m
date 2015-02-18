Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B00511A0AC6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 07:56:11 +1100 (AEDT)
Received: by mail-wi0-f174.google.com with SMTP id em10so43910849wid.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 12:56:06 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 18 Feb 2015 21:56:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150218205603.GA21074@gmail.com>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com>
 <20150209121132.GB3952@krava.redhat.com>
 <20150209132557.GA8099@gmail.com>
 <20150209204019.GA13991@two.firstfloor.org>
 <1423613998.2713.16.camel@aoeu.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423613998.2713.16.camel@aoeu.buserror.net>
Cc: Tom Huynh <tom.huynh@freescale.com>, Peter Zijlstra <peterz@infradead.org>,
 Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, acme@kernel.org,
 Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, mingo@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Scott Wood <scottwood@freescale.com> wrote:

> On Mon, 2015-02-09 at 21:40 +0100, Andi Kleen wrote:
> > > I'll NAK any external 'download area' (and I told that Andi 
> > > before): tools/perf/event-tables/ or so is a good enough 
> > > 'download area' with fast enough update cycles.
> > 
> > The proposal was to put it on kernel.org, similar to how
> > external firmware blobs are distributed. [...]

Fortunately perf is not an external firmware blob ...

> > [...] CPU event lists are data sheets, so are like 
> > firmware. [...]

What an absolute, idiotic, nonsense argument!

CPU event lists are human readable descriptions for events. 
If they aren't then they have no place in tooling.

Treating them like firmware is as backwards as it gets.

> > [...]  They do not follow the normal kernel code 
> > licenses. They are not source code. They cannot be 
> > reviewed in the normal way.
> 
> How is it different from describing registers and bits in 
> driver header files?  What does it mean to talk about a 
> license on information, rather than the expression of 
> information?

Andi is making idiotic arguments, instead of implementing 
the technically sane solution.

Thanks,

	Ingo
