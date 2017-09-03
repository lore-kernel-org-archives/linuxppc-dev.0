Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlSY56ssTzDrhs
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Sep 2017 19:36:40 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.13: Reported regressions as of Sunday, 2017-09-03
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <12c76b2b-9985-ffff-afe2-2382c24bcc72@leemhuis.info>
Date: Sun, 3 Sep 2017 11:36:31 +0200
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

Hi! Find below my fifth regression report for Linux 4.13. It lists 4
regressions I'm currently aware of. There are no new ones; 2 got fixed
since the last report.

You can also find the report at http://bit.ly/lnxregrep413 where I try
to update it every now and then.

As always: Are you aware of any other regressions? Then please let me
know. For details see http://bit.ly/lnxregtrackid And please tell me if
there is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Thx to all those that CCed me on regression reports or provided
other input, it makes compiling these reports a whole lot easier!

== Current regressions ==

[x86/mm/gup] e585513b76: will-it-scale.per_thread_ops -6.9% regression
Status: Asked on the list, but looks like issue gets ignored by everyone
Note: I'm a bit unsure if adding this issue to this list was a good
idea. Side note: Was reported against linux-next in May already
Reported: 2017-07-10
http://lkml.kernel.org/r/20170710024020.GA26389@yexl-desktop
Cause: https://git.kernel.org/torvalds/c/e585513b76f7

[lkp-robot] [Btrfs] 28785f70ef: xfstests.generic.273.fail
Status: Jeff: "We're not ignoring it. […] collection of bugs that
approximate a correct result, and we're addressing them individually.[…]"
Reported: 2017-07-26 Last known developer activity: 2017-08-10
https://lkml.kernel.org/r/20170726062352.GC4877@yexl-desktop
https://lkml.kernel.org/r/bcd49705-e63a-4439-1620-57cd16f5bc09@suse.com
Cause: https://git.kernel.org/torvalds/c/28785f70ef88
Linux-Regression-ID: lr#a7d273

Build regression: cc1: error: '-march=r3000' requires '-mfp32'
Note: is there any way to query 0-day to see if this is still happening?
Reported: 2017-08-13
https://lkml.org/lkml/2017/8/13/38
Cause: https://git.kernel.org/torvalds/c/89a55278dee4

usb:xhci: regression when ATI chipsets detected
Status: Fix in usb-next/usb-testing
Reported: 2017-08-23 Last known developer activity: 2017-08-28
https://lkml.kernel.org/r/1503485760-15146-1-git-send-email-Sandeep.Singh@amd.com
Cause: https://git.kernel.org/torvalds/c/e788787ef4f9


== Fixed since last report ==

[Dell xps13 9630] Could not be woken up from suspend-to-idle via usb
keyboard
Status: was a tracking bug that got closed by the developer that created it
Reported: 2017-07-24
https://bugzilla.kernel.org/show_bug.cgi?id=196459
Cause: https://git.kernel.org/torvalds/c/33e4f80ee69b
Linux-Regression-ID: lr#bd29ab

CIFS mount error -112 due to "SMB3 by default for security reasons"
Status: Situation not perfect, but improved a lot by
https://git.kernel.org/torvalds/c/7e682f766f28
Note: https://lkml.org/lkml/2017/8/31/843
Reported: 2017-08-06
https://bugzilla.kernel.org/show_bug.cgi?id=196599
Cause: https://git.kernel.org/torvalds/c/eef914a9eb5e /
https://git.kernel.org/torvalds/c/908b852df1d5
Linux-Regression-ID: lr#60efe5
