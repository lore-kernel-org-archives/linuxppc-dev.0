Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y4lmq6V1QzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Oct 2017 00:01:45 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.14: Reported regressions as of Sunday, 2017-10-01
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <605f9896-b0d4-d5f5-06ee-1f1d9e0069bd@leemhuis.info>
Date: Sun, 1 Oct 2017 15:01:35 +0200
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

Hi! Find below my first regression report for Linux 4.14. It lists 4
regressions I'm currently aware of (two of the reports are my own). I
skimmed LKML, bugzilla.kernel.org, but those were all I found that
looked worthy. And nobody pointed me to any regressions directly. Sigh.
Either we are doing really well this cycle or nobody wants his
regression tracked...

As always: Are you aware of any other regressions? Then please let me
know by mail (a simple bounce in my direction is enough!). For details
see http://bit.ly/lnxregtrackid And please tell me if there is anything
in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Module removal-related regression
Status: Fix "driver core: suppress sending MODALIAS in UNBIND uevents"
is sitting in greg's driver-core-linus
Reported: 2017-09-09
https://marc.info/?l=linux-kernel&m=150497889508778
Cause: 1455cf8dbfd06aa7651dcfccbadb7a093944ca65

stalls, short lived or long lived lockups very shortly after boot.
Status: Nothing new since 10+ days; maybe fixed already? poked list for
a status update
Reported: 2017-09-19
https://marc.info/?l=linux-kernel&m=150583434416295
Cause: 74def747bcd0

CIFS SMB2+ combined with pythons xattr.listxattr leads to "IOError:
[Errno 61]"
Status: no reaction from developers yet; need to poke list again
Note: Disclaimer: A regression the regression tracker reported
Reported: 2017-09-26
https://marc.info/?l=linux-cifs&m=150644485708526
Cause: 8dc5b3a6cb2f (assumed)

Ath10k disconnects
Status: brand new, might turn out to be a false alarm
Note: Disclaimer: A regression the regression tracker reported
Reported: 2017-10-01
http://lists.infradead.org/pipermail/ath10k/2017-October/010189.html


== Reported, but not added to the report for one reason or another ==

New default s2idle does not work on Dell XPS 13 9360
Status: Might be fixed, asked for a status update.
https://bugzilla.kernel.org/show_bug.cgi?id=196907

dd1c1f2f20: will-it-scale.per_process_ops -5% regression
Status: Linus: "Sadly, while I love the concept of performance tracking,
the "will-it-scale" reports haven't really been reliable enough to
really be useful." https://lkml.org/lkml/2017/9/3/103
https://marc.info/?l=linux-kernel&m=150457748221543

52306e882f: stress-ng.lockofd.ops_per_sec -11% regression
Status: see above
https://marc.info/?l=linux-kernel&m=150658588810343

9e52fc2b50:  will-it-scale.per_thread_ops -16% regression
Status: see above; but there was some discussion about this here, so
maybe it should be on the list
https://marc.info/?l=linux-kernel&m=150649209519462
