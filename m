Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E83D92C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 10:29:12 +1100 (EST)
Date: Wed, 5 Mar 2014 00:29:04 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [tip:irq/core] powerpc: eeh: Fixup the brown paperbag fallout
 of the "cleanup"
In-Reply-To: <1393975112.10727.103.camel@pasglop>
Message-ID: <alpine.DEB.2.02.1403050027560.18573@ionos.tec.linutronix.de>
References: <tip-57310c3c99eb6fab2ecbd63aa3f7c323341ca77e@git.kernel.org>
 <1393975112.10727.103.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: shangw@linux.vnet.ibm.com, linux-tip-commits@vger.kernel.org,
 peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Mar 2014, Benjamin Herrenschmidt wrote:

> On Tue, 2014-03-04 at 15:15 -0800, tip-bot for Thomas Gleixner wrote:
> > Commit-ID:  57310c3c99eb6fab2ecbd63aa3f7c323341ca77e
> > Gitweb:     http://git.kernel.org/tip/57310c3c99eb6fab2ecbd63aa3f7c323341ca77e
> > Author:     Thomas Gleixner <tglx@linutronix.de>
> > AuthorDate: Wed, 5 Mar 2014 00:06:11 +0100
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Wed, 5 Mar 2014 00:13:33 +0100
> > 
> > powerpc: eeh: Fixup the brown paperbag fallout of the "cleanup"
> > 
> > Commit b8a9a11b9 (powerpc: eeh: Kill another abuse of irq_desc) is
> > missing some brackets .....
> > 
> > It's not a good idea to write patches in grumpy mode and then forget
> > to at least compile test them or rely on the few eyeballs discussing
> > that patch to spot it.....
> 
> Ouch :-)
> 
> Next time you have a series like that, if you want I'll throw it at my
> build tester.

You simply could have been less lazy and picked up the whole ppc
related stuff instead of ignoring it....

Thanks,

	tglx
