Return-Path: <linus971@gmail.com>
Received: from mail-it0-x236.google.com (mail-it0-x236.google.com
 [IPv6:2607:f8b0:4001:c0b::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlfb768RqzDqjs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 03:09:07 +1000 (AEST)
Received: by mail-it0-x236.google.com with SMTP id t134so5974888ita.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Sep 2017 10:09:07 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <12c76b2b-9985-ffff-afe2-2382c24bcc72@leemhuis.info>
References: <12c76b2b-9985-ffff-afe2-2382c24bcc72@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Sep 2017 10:09:05 -0700
Message-ID: <CA+55aFwYXH=M2zm+eZ6+28g+ivLO1J0ubzA-=PNnVnZmLbMROw@mail.gmail.com>
Subject: Re: Linux 4.13: Reported regressions as of Sunday, 2017-09-03
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 3, 2017 at 2:36 AM, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [x86/mm/gup] e585513b76: will-it-scale.per_thread_ops -6.9% regression
> Status: Asked on the list, but looks like issue gets ignored by everyone
> Note: I'm a bit unsure if adding this issue to this list was a good
> idea. Side note: Was reported against linux-next in May already
> Reported: 2017-07-10
> http://lkml.kernel.org/r/20170710024020.GA26389@yexl-desktop
> Cause: https://git.kernel.org/torvalds/c/e585513b76f7

Sadly, while I love the concept of performance tracking, the
"will-it-scale" reports haven't really been reliable enough to really
be useful. There is a _ton_ of noise in the numbers, and the
test-cases don't seem to be stable enough to really track sanely.

I wish it was otherwise, because we also got a report of "57.3%
improvement of will-it-scale.per_process_ops" this release.

So I find the kernel test robot performance tracking very interesting
in theory, but as things stand now I think it's just that:
"interesting". Not quite ready for action.

                 Linus
