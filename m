Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-we0-x22f.google.com (mail-we0-x22f.google.com
 [IPv6:2a00:1450:400c:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1D661A0012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 23:28:49 +1000 (EST)
Received: by mail-we0-f175.google.com with SMTP id t60so936818wes.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 06:28:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 16 Jul 2014 15:28:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: [PATCH v5 2/2] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
Message-ID: <20140716132838.GA18597@gmail.com>
References: <1404276081.7254.1.camel@concordia>
 <20140702070029.14689.18485.stgit@kbuild-fedora.novalocal>
 <1405394370.17767.7.camel@concordia>
 <1405408602.9343.75.camel@pasglop> <53C4FDC8.9050801@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53C4FDC8.9050801@hitachi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, "Suzuki K. Poulose" <suzuki@in.ibm.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
 yrl.pp-manager.tt@hitachi.com, akataria@vmware.com,
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


* Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:

> (2014/07/15 16:16), Benjamin Herrenschmidt wrote:
> > On Tue, 2014-07-15 at 13:19 +1000, Michael Ellerman wrote:
> > 
> >>> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> >>> Reported-by: Tony Luck <tony.luck@gmail.com>
> >>> Tested-by: Tony Luck <tony.luck@intel.com>
> >>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>
> >> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> >> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (for powerpc)
> >>
> >> Ben, can you take this in your tree?
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > That looks more like generic material. Do we have a kprobes maintainer ?
> > Andrew, do you want to take this ?
> 
> Yeah, I usually use Ingo's tip tree for kprobes maintenance.
> Ingo, could you pull this as urgent-for-linus patch?

Mind resending it in a separate thread with all acks added, etc?

Thanks,

	Ingo
