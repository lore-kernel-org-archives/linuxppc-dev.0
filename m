Return-Path: <fedora@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sC2TX1l7FzDqgN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 01:24:00 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.8: Reported regressions as of Sunday, 2016-08-14
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <0a505ad8-88ad-810e-b01a-5869406392d7@leemhuis.info>
Date: Sun, 14 Aug 2016 17:23:56 +0200
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

Hi! Here is my first regression report for Linux 4.8. It lists 11
regressions. I was told or found about 10 more, but it turned out all 
of them were fixed already in the past few days. Nice, but this in one 
of the reasons why compiling this report took way more hours than the 
past few reports :-/

Anyway: Are you aware of any other regressions? Then please let me 
know. And you know the drill: if there is anything on the report that 
shouldn't be there please let me know.

Ciao, Thorsten

P.S.: Gmane, I still miss you a lot :-/

P.P.S.: "There are only two hard things in Computer Science: cache 
invalidation, naming things, and off-by-one errors" is my reply to 
those that asked to lend my time machine after reading the line "I'll
send the first regression report for 4.9 next week" that last weeks
report contained ;-)

== Current regressions ==

Desc: irqdomain: Don't set type when mapping an IRQ breaks nexus7 gpio buttons
Repo: 2016-07-30 https://marc.info/?l=linux-kernel&m=146985356305280&w=2
Stat: 2016-08-12 https://marc.info/?l=linux-kernel&m=147099735609904&w=2
Note: wip

Desc: genirq: Flags mismatch irq 8, 00000088 (mmc0) vs. 00000080 (rtc0). mmc0: Failed to request irq 8: -16
Repo: 2016-08-01 https://bugzilla.kernel.org/show_bug.cgi?id=150881
Stat: 2016-08-13 https://bugzilla.kernel.org/show_bug.cgi?id=150881#c26
Note: wip

Desc: Failed to create /dev/root: -14 after commit e6978e4bf1 (ARM: save and reset the address limit when entering an exception)
Repo: 2016-08-02 https://lkml.org/lkml/2016/8/2/2085
Stat: 2016-08-11 https://lkml.org/lkml/2016/8/10/858
Note: patch heading upstream

Desc: wlcore: NULL pointer dereference in wlcore_op_get_expected_throughput
Repo: 2016-08-04 https://marc.info/?l=linux-kernel&m=147031427806879&w=2
Stat: n/a 
Note: patches heading upstream

Desc: Crashes in refresh_zone_stat_thresholds when some nodes have no memory
Repo: 2016-08-04 https://marc.info/?t=147029321800001&r=1&w=2
Stat: n/a 
Note: nothing happened since the report

Desc: Intermittent crash on reboot (acpi_ex_system_reset_event)
Repo: 2016-08-04 https://bugzilla.kernel.org/show_bug.cgi?id=151441
Stat: 2016-08-10 https://bugzilla.kernel.org/show_bug.cgi?id=151441#c2
Note: wip

Desc: [lkp] [mm, page_alloc] e6cbd7f2ef: pixz.throughput -5.1% regression due to mm, page_alloc: remove fair zone allocation policy
Repo: 2016-08-08 https://marc.info/?l=linux-kernel&m=147064515210332&w=3
Stat: n/a 
Note: nothing happened since the report

Desc: [lkp] [xfs] 68a9f5e700: aim7.jobs-per-min -13.6% regression
Repo: 2016-08-09 http://www.spinics.net/lists/kernel/msg2317052.html
Stat: 2016-08-14 http://www.spinics.net/lists/kernel/msg2320159.html
Note: wip

Desc: 362899b (macvtap: switch to use skb array) causes oops during teardown
Repo: 2016-08-10 http://www.spinics.net/lists/netdev/msg389465.html
Stat: 2016-08-10 http://www.spinics.net/lists/netdev/msg389465.html
Note: tested fix: http://www.spinics.net/lists/netdev/msg389623.html

Desc: mmc: Secure discard is broken
Repo: 2016-08-11 http://www.spinics.net/lists/linux-mmc/msg38481.html
Stat: 2016-08-11 http://www.spinics.net/lists/linux-mmc/msg38491.html
Note: report contains patch

Desc: imx-drm: Possible regression after update to atomic: black screen after Weston starts
Repo: 2016-08-13 http://www.spinics.net/lists/kernel/msg2320013.html
Stat: n/a 
Note: 
