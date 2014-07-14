Return-Path: <tony.luck@gmail.com>
Received: from mail-vc0-x22d.google.com (mail-vc0-x22d.google.com
 [IPv6:2607:f8b0:400c:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DF711A013F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 03:17:55 +1000 (EST)
Received: by mail-vc0-f173.google.com with SMTP id hy10so3958569vcb.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jul 2014 10:17:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53BBDEE6.1080800@hitachi.com>
References: <1404276081.7254.1.camel@concordia>
 <20140702070029.14689.18485.stgit@kbuild-fedora.novalocal>
 <53BBDEE6.1080800@hitachi.com>
Date: Mon, 14 Jul 2014 10:17:52 -0700
Message-ID: <CA+8MBbJH3EfiGctxLpXScGEtvBNXkNVYEnyahihnCie1FgO+9Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] [BUGFIX] kprobes: Fix "Failed to find blacklist"
 error on ia64 and ppc64
From: Tony Luck <tony.luck@gmail.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, sparse@chrisli.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 akataria@vmware.com, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>,
 Chris Wright <chrisw@sous-sol.org>, yrl.pp-manager.tt@hitachi.com,
 Thomas Gleixner <tglx@linutronix.de>, Kevin Hao <haokexin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, rdunlap@infradead.org,
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

On Tue, Jul 8, 2014 at 5:07 AM, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> Ping?
>
> This patch can be applied without 1/2, and will fix ia64/ppc64 problem.

Is somebody going to push this upstream? Another week has gone by,
we are at -rc5, and I'm still seeing the

  Failed to find blacklist a00000010133b150

messages on ia64.

-Tony
