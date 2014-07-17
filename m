Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by lists.ozlabs.org (Postfix) with ESMTP id B87BE1A01BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 21:41:04 +1000 (EST)
Message-ID: <53C7B649.1070004@hitachi.com>
Date: Thu, 17 Jul 2014 20:40:57 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: Re: [RESEND PATCH v5] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
References: <20140717071121.3130.86341.stgit@kbuild-fedora.novalocal>
 <20140717093832.GB4232@gmail.com> <53C7B0E6.1050503@hitachi.com>
In-Reply-To: <53C7B0E6.1050503@hitachi.com>
Content-Type: text/plain; charset=ISO-8859-1
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

(2014/07/17 20:17), Masami Hiramatsu wrote:
> (2014/07/17 18:38), Ingo Molnar wrote:
>>
>> * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
>>
>>> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>>> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
>>
>> Looks good, but this is not a valid SOB sequence: if Suzuki wrote the 
>> patch then he should be the first SOB (and should have a From line as 
>> well), if he acked it along the way then it should be an Acked-by - or 
>> Reviewed-by.
> 
> Ah, OK, so I'll add his name as Fixed-by:.

Oops, I also found that an old comment in the patch description
and unneeded "include". I'll fix and send that asap.

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
