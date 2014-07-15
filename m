Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 247BE1A0149
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:40:37 +1000 (EST)
Message-ID: <1405408602.9343.75.camel@pasglop>
Subject: Re: [PATCH v5 2/2] [BUGFIX] kprobes: Fix "Failed to find blacklist"
 error on ia64 and ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 15 Jul 2014 17:16:42 +1000
In-Reply-To: <1405394370.17767.7.camel@concordia>
References: <1404276081.7254.1.camel@concordia>
 <20140702070029.14689.18485.stgit@kbuild-fedora.novalocal>
 <1405394370.17767.7.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, akataria@vmware.com,
 linux-tip-commits@vger.kernel.org, anil.s.keshavamurthy@intel.com,
 Ingo Molnar <mingo@kernel.org>, "Suzuki K. Poulose" <suzuki@in.ibm.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
 yrl.pp-manager.tt@hitachi.com, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Kevin Hao <haokexin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, rdunlap@infradead.org,
 Tony Luck <tony.luck@gmail.com>, dl9pf@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-15 at 13:19 +1000, Michael Ellerman wrote:

> > Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> > Reported-by: Tony Luck <tony.luck@gmail.com>
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (for powerpc)
> 
> Ben, can you take this in your tree?

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

That looks more like generic material. Do we have a kprobes maintainer ?
Andrew, do you want to take this ?

I'm happy to put it in powerpc and send it to Linus tomorrow if nobody
cares :-)

Cheers,
Ben.
