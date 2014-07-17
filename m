Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-we0-x22b.google.com (mail-we0-x22b.google.com
 [IPv6:2a00:1450:400c:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C67CD1A0009
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 19:38:49 +1000 (EST)
Received: by mail-we0-f171.google.com with SMTP id p10so2202588wes.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 02:38:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 17 Jul 2014 11:38:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [RESEND PATCH v5] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
Message-ID: <20140717093832.GB4232@gmail.com>
References: <20140717071121.3130.86341.stgit@kbuild-fedora.novalocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140717071121.3130.86341.stgit@kbuild-fedora.novalocal>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Tony Luck <tony.luck@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, "Suzuki K. Poulose" <suzuki@in.ibm.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
 yrl.pp-manager.tt@hitachi.com, akataria@vmware.com,
 Tony Luck <tony.luck@intel.com>, Kevin Hao <haokexin@gmail.com>,
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


* Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:

> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Looks good, but this is not a valid SOB sequence: if Suzuki wrote the 
patch then he should be the first SOB (and should have a From line as 
well), if he acked it along the way then it should be an Acked-by - or 
Reviewed-by.

This fix should be in v3.16 as well, right?

Thanks,

	Ingo
