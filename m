Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yFYm81LKnzDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 08:01:44 +1100 (AEDT)
Date: Sun, 15 Oct 2017 22:52:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.14: Reported regressions as of Sunday, 2017-10-15
Message-ID: <20171015205201.sxd3pfzelkoaqs62@pd.tnic>
References: <4c4f5dc2-78d1-f7bd-6905-360d1633fc18@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4c4f5dc2-78d1-f7bd-6905-360d1633fc18@leemhuis.info>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 15, 2017 at 02:55:24PM +0200, Thorsten Leemhuis wrote:
> == Fixed since last report ==
> 
> "hangs when building e.g. perf" & "Random insta-reboots on AMD Phenom II"
> Status: Fixed by https://git.kernel.org/torvalds/c/67bb8e999e0a

That should be: b956575bed91 ("x86/mm: Flush more aggressively in lazy TLB mode")

> Reported: 2017-09-05
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1484723.html
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1501379.html
> https://lkml.kernel.org/r/cover.1508000261.git.luto@kernel.org
> Cause: 94b1b03b519b81c494900cb112aa00ed205cc2d9

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
