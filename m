Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xL40F2PVhzDr2y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 23:57:32 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id q70so18298042oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 06:57:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8fb88126-2553-9f25-d4ef-fa0c561e186e@leemhuis.info>
References: <8fb88126-2553-9f25-d4ef-fa0c561e186e@leemhuis.info>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Jul 2017 16:57:29 +0300
Message-ID: <CAHp75VdaSAGePQj__dbMDmegdFT66=ShwdPYoGToB3SOWRni2A@mail.gmail.com>
Subject: Re: Linux 4.13: Reported regressions as of Sunday, 2017-07-30
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 30, 2017 at 4:49 PM, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
> Hi! Find below my first regression report for Linux 4.13. It lists 8
> regressions I'm currently aware of (a few others I had on my list got
> fixed in the past few days). You can also find it at
> http://bit.ly/lnxregrep413 where I try to update it every now and then.
>
> As always: Are you aware of any other regressions? Then please let me
> know. For details see http://bit.ly/lnxregtrackid
> And please tell me if there is anything in the report that shouldn't be
> there.

> P.S.: Thx to all those that CCed me on regression reports or provided
> other input, it makes compiling these reports a whole lot easier!

> Null dereference in rt5677_i2c_probe()
> 2017-07-17 lr#96bd63 https://bugzilla.kernel.org/show_bug.cgi?id=196397
> Due to https://git.kernel.org/torvalds/c/a36afb0ab6

> Status: Takashi proposed a patch that fixes the issue

Status is outdated as per discussion, Patch is available in upstream
as commit ddc9e69b9dc2.

> Latest discussion: https://bugzilla.kernel.org/show_bug.cgi?id=196397#c6
> (2017-07-17)

...while this one is correct link.

-- 
With Best Regards,
Andy Shevchenko
