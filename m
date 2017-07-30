Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xL4XQ4tPzzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 00:21:56 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.13: Reported regressions as of Sunday, 2017-07-30
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <8fb88126-2553-9f25-d4ef-fa0c561e186e@leemhuis.info>
Date: Sun, 30 Jul 2017 15:49:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi! Find below my first regression report for Linux 4.13. It lists 8
regressions I'm currently aware of (a few others I had on my list got
fixed in the past few days). You can also find it at
http://bit.ly/lnxregrep413 where I try to update it every now and then.

As always: Are you aware of any other regressions? Then please let me
know. For details see http://bit.ly/lnxregtrackid
And please tell me if there is anything in the report that shouldn't be
there.

Ciao, Thorsten

P.S.: Thx to all those that CCed me on regression reports or provided
other input, it makes compiling these reports a whole lot easier!

== Current regressions ==

[x86/mm/gup] e585513b76: will-it-scale.per_thread_ops -6.9% regression
2017-07-10 http://lkml.kernel.org/r/20170710024020.GA26389@yexl-desktop
Due to https://git.kernel.org/torvalds/c/e585513b76

Null dereference in rt5677_i2c_probe()
2017-07-17 lr#96bd63 https://bugzilla.kernel.org/show_bug.cgi?id=196397
Due to https://git.kernel.org/torvalds/c/a36afb0ab6
Status: Takashi proposed a patch that fixes the issue
Latest discussion: https://bugzilla.kernel.org/show_bug.cgi?id=196397#c6
(2017-07-17)

[I945GM] Pasted text not shown after mouse middle-click
2017-07-17 lr#d672f3 https://bugs.freedesktop.org/show_bug.cgi?id=101819
Status: could not get reproduced yet
Notes: related to the regression that was fixed rc2+
https://bugs.freedesktop.org/show_bug.cgi?id=101790

[Dell xps13 9630] Could not be woken up from suspend-to-idle via usb
keyboard
2017-07-24 lr#bd29ab https://bugzilla.kernel.org/show_bug.cgi?id=196459
Due to https://git.kernel.org/torvalds/c/33e4f80ee6
Status: it's a tracking bug, looks like issue is handled by Intel devs
already
Notes: suspend-to-idle is rare

[lkp-robot] [Btrfs]  28785f70ef: xfstests.generic.273.fail
2017-07-26 lr#a7d273
https://lkml.kernel.org/r/20170726062352.GC4877@yexl-desktop Due to
https://git.kernel.org/torvalds/c/28785f70ef

Dell XPS 13 9360: Touchscreen does not report events
2017-07-28 lr#fe68bb https://bugzilla.kernel.org/show_bug.cgi?id=196519
Status: afaics waiting to get forwarded to linux-usb by reporter
Notes: might be the same as
https://bugzilla.kernel.org/show_bug.cgi?id=196431

Xen HVM guest with KASLR enabled wouldn't boot any longer
2017-07-28 https://lkml.kernel.org/r/20170728102314.29100-1-jgross@suse.com
Status: WIP, patches up for review

NULL pointer deref in networking
2017-07-29 lr#084be9 https://bugzilla.kernel.org/show_bug.cgi?id=196529
Status: told reporter he might be better off posting to netdev
