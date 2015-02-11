Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0139.outbound.protection.outlook.com [207.46.100.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5723B1A03C8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 11:20:13 +1100 (AEDT)
Message-ID: <1423613998.2713.16.camel@aoeu.buserror.net>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
From: Scott Wood <scottwood@freescale.com>
To: Andi Kleen <andi@firstfloor.org>
Date: Tue, 10 Feb 2015 18:19:58 -0600
In-Reply-To: <20150209204019.GA13991@two.firstfloor.org>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com> <20150209121132.GB3952@krava.redhat.com>
 <20150209132557.GA8099@gmail.com>
 <20150209204019.GA13991@two.firstfloor.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Tom Huynh <tom.huynh@freescale.com>, Peter Zijlstra <peterz@infradead.org>,
 Jiri
 Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, acme@kernel.org,
 mingo@redhat.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-09 at 21:40 +0100, Andi Kleen wrote:
> > I'll NAK any external 'download area' (and I told that Andi 
> > before): tools/perf/event-tables/ or so is a good enough 
> > 'download area' with fast enough update cycles.
> 
> The proposal was to put it on kernel.org, similar to how
> external firmware blobs are distributed. CPU event lists
> are data sheets, so are like firmware. They do not
> follow the normal kernel code licenses. They are not 
> source code. They cannot be reviewed in the normal way.

How is it different from describing registers and bits in driver header
files?  What does it mean to talk about a license on information, rather
than the expression of information?

-Scott
