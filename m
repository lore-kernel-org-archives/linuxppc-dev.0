Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C0291A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 12:11:04 +1000 (EST)
Message-ID: <1405390262.17767.5.camel@concordia>
Subject: Re: [PATCH v5 2/2] [BUGFIX] kprobes: Fix "Failed to find blacklist"
 error on ia64 and ppc64
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tony Luck <tony.luck@gmail.com>
Date: Tue, 15 Jul 2014 12:11:02 +1000
In-Reply-To: <CA+8MBbJH3EfiGctxLpXScGEtvBNXkNVYEnyahihnCie1FgO+9Q@mail.gmail.com>
References: <1404276081.7254.1.camel@concordia>
 <20140702070029.14689.18485.stgit@kbuild-fedora.novalocal>
 <53BBDEE6.1080800@hitachi.com>
 <CA+8MBbJH3EfiGctxLpXScGEtvBNXkNVYEnyahihnCie1FgO+9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, sparse@chrisli.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, akataria@vmware.com,
 linux-tip-commits@vger.kernel.org, anil.s.keshavamurthy@intel.com,
 Ingo Molnar <mingo@kernel.org>, "Suzuki K. Poulose" <suzuki@in.ibm.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
 yrl.pp-manager.tt@hitachi.com, Thomas Gleixner <tglx@linutronix.de>,
 Kevin Hao <haokexin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 rdunlap@infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl9pf@gmx.de,
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

On Mon, 2014-07-14 at 10:17 -0700, Tony Luck wrote:
> On Tue, Jul 8, 2014 at 5:07 AM, Masami Hiramatsu
> <masami.hiramatsu.pt@hitachi.com> wrote:
> > Ping?
> >
> > This patch can be applied without 1/2, and will fix ia64/ppc64 problem.
> 
> Is somebody going to push this upstream? Another week has gone by,
> we are at -rc5, and I'm still seeing the
> 
>   Failed to find blacklist a00000010133b150
> 
> messages on ia64.

I don't see those messages on ppc64, I don't know where the original report
that it was broken on ppc64 came from. So I'm a bit lukewarm on the patch.

cheers
