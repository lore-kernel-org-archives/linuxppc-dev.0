Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQMjX1n30zDqjD
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 23:59:41 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.13: Reported regressions as of Sunday, 2017-08-06
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
Date: Sun, 6 Aug 2017 15:59:34 +0200
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

Hi! Find below my second regression report for Linux 4.13. It lists 10
regressions I'm currently aware of (albeit in one case it's not entirely
clear yet if it's a regression in 4.13). One regression got fixed since
last weeks report. You can also find the report at
http://bit.ly/lnxregrep413 where I try to update it every now and then.

As always: Are you aware of any other regressions? Then please let me
know. For details see http://bit.ly/lnxregtrackid And please tell me if
there is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Thx to all those that CCed me on regression reports or provided
other input, it makes compiling these reports a whole lot easier!

== Current regressions ==

[x86/mm/gup] e585513b76: will-it-scale.per_thread_ops -6.9% regression
(2017-07-10)
http://lkml.kernel.org/r/20170710024020.GA26389@yexl-desktop
Status: Asked on the list, but issue still gets ignored by everyone
Cause: https://git.kernel.org/torvalds/c/e585513b76
Note: I'm a bit unsure if adding this issue to this list was a good idea.

Null dereference in rt5677_i2c_probe() (2017-07-17)
https://bugzilla.kernel.org/show_bug.cgi?id=196397
Linux-Regression-ID: lr#96bd63
Status: Patch is available in in asoc-next as commit ddc9e69b9dc2, but
was not part of the changes to this subsystem that got merged a few days ago
Cause: https://git.kernel.org/torvalds/c/a36afb0ab6
Latest: https://bugzilla.kernel.org/show_bug.cgi?id=196397#c6 (2017-07-17)

[I945GM] Pasted text not shown after mouse middle-click (2017-07-17)
https://bugs.freedesktop.org/show_bug.cgi?id=101819
Linux-Regression-ID: lr#d672f3
Status: could not get reproduced yet
Note: looks like it's getting ignored
Latest: https://bugs.freedesktop.org/show_bug.cgi?id=101819#c8 (2017-07-17)

[Dell xps13 9630] Could not be woken up from suspend-to-idle via usb
keyboard (2017-07-24)
https://bugzilla.kernel.org/show_bug.cgi?id=196459
Linux-Regression-ID: lr#bd29ab
Status: it's a tracking bug, looks like issue is handled by Intel devs
already
Cause: https://git.kernel.org/torvalds/c/33e4f80ee6
Note: suspend-to-idle is rare

[lkp-robot] [Btrfs]  28785f70ef: xfstests.generic.273.fail (2017-07-26)
https://lkml.kernel.org/r/20170726062352.GC4877@yexl-desktop
Linux-Regression-ID: lr#a7d273
Status: Seems it gets ignored by everyone
Cause: https://git.kernel.org/torvalds/c/28785f70ef

Xen HVM guest with KASLR enabled wouldn't boot any longer  (2017-07-28)
https://lkml.kernel.org/r/20170728102314.29100-1-jgross@suse.com
Status: WIP, patches up for review, but were not part of the changes to
this subsystem that got merged a few days ago

bio-integrity: Fix regression if profile verify_fn is NULL (2017-08-02)
https://lkml.kernel.org/r/20170802122750.12216-1-gmazyland@gmail.com
Linux-Regression-ID: lr#35498d
Status: Discussion ongoing how to fix it properly
Latest: https://lkml.kernel.org/r/yq13795epil.fsf@oracle.com (2017-08-02)

CIFS mount error -112 (2017-08-06)
https://bugzilla.kernel.org/show_bug.cgi?id=196599
Linux-Regression-ID: lr#60efe5
Status: Brand new


== Waiting for reporter ==

NULL pointer deref in networking (2017-07-29)
https://bugzilla.kernel.org/show_bug.cgi?id=196529
Linux-Regression-ID: lr#084be9
Status: maybe reporter lost interest

SGI UV300/UV300: kernel BUG at arch/x86/mm/init_64.c:350! during boot
(2017-08-02)
https://bugzilla.kernel.org/show_bug.cgi?id=196561
Status: not 100% sure if this is a regression
Note: related to https://bugzilla.kernel.org/show_bug.cgi?id=196565 ?


== Fixed since last weeks report ==

Dell XPS 13 9360: Touchscreen does not report events (2017-07-28)
https://bugzilla.kernel.org/show_bug.cgi?id=196519
Linux-Regression-ID: lr#fe68bb
Status: Fixed in rc3


== Legend ==

First few lines -> short summary followed by date and a link to the
 report that lead to inclusion in this report
Cause -> commit that causes this regression
Status -> short start summary written by regression tracker
Note -> additional note written by regression tracker
Latest -> most recent and informative point where issue was discussed
See also -> other places where this issue was or is discussed

Everything apart from the description and the link to the report is
optional.

EOF
