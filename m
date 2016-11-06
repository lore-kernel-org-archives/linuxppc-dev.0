Return-Path: <regressions@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBbXK5GCbzDvP0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 00:10:09 +1100 (AEDT)
Subject: Re: Linux 4.9: Reported regressions as of Sunday, 2016-10-30
To: Paul Bolle <pebolle@tiscali.nl>
References: <0eb29167-7908-e049-6927-d9c6b093970d@leemhuis.info>
 <1477988293.2230.36.camel@tiscali.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <3b39cb73-8cb7-74b4-0a71-6966ac2798d3@leemhuis.info>
Date: Sun, 6 Nov 2016 14:10:03 +0100
MIME-Version: 1.0
In-Reply-To: <1477988293.2230.36.camel@tiscali.nl>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lo! On 01.11.2016 09:18, Paul Bolle wrote:
> On Sun, 2016-10-30 at 14:20 +0100, Thorsten Leemhuis wrote:
>> As always: Are you aware of any other regressions? Then please let me
>> know (simply CC regressions@leemhuis.info).
> Do build regressions count?

That's a good question.

> Because I was trying to fix an obscure build issue in arch/mips, choose
> a random configuration that should hit that issue, and promptly ran
> into
> https://lkml.kernel.org/r/<201610301405.K82KqqW0%25fengguang.wu@intel.com>
> The same configuration does build under v4.8, I tested that of course.

I'd say it's a practical problem that users run into and hence it's a
regression. Sure, in this case it hits only those that compile kernels
themselves; but those are users, too, and we don't want to scare them
away with things that suddenly stop working.

IOW: I'll include it in this weeks report.

Ciao, Thorsten
