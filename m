Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjB4G0HD7zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 21:36:42 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.11: Reported regressions as of Tuesday, 20176-03-14
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <5d399102-c648-7a87-1dff-f8b74c12ceaa@leemhuis.info>
Date: Tue, 14 Mar 2017 11:02:23 +0100
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

Hi! Find below my first regression report for Linux 4.11. It lists 9
regressions I'm currently aware of.

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Sorry, I didn't compile any regression reports for 4.10: I 
didn't find time due to various reasons (vacation, a cold, regular 
work, and attending two conferences). Reminder: compiling these reports
has nothing to do with my paid job and I'm doing it in my spare time
just because I think someone should do it.

P.P.S: Dear Gmane mainling list archive webinterface, please come
back soon. I really really miss you. It hurts ever single day.
Don't you miss me, too? ;-)

== Current regressions ==

Desc: PowerPC crashes on boot, bisected to commit 5657933dbb6e
Repo: 2017-03-02 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1343553.html
Stat: 2017-03-09 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1349568.html
Note: patch hopefully heading mainline

Desc: thinkpad x220: GPU hang
Repo: 2017-03-05 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1345689.html
Stat: n/a 
Note: poked discussion for a status update

Desc: e1000e: __pci_enable_msi_range fails before/after resume
Repo: 2017-03-06 https://bugzilla.kernel.org/show_bug.cgi?id=194801
Stat: 2017-03-06 https://bugzilla.kernel.org/show_bug.cgi?id=194801#c1
Note: poked bug for status; might need to get forwared to network people

Desc: Two batteries is detected on DEXP Ursus 7W tablet instead of one
Repo: 2017-03-07 https://bugzilla.kernel.org/show_bug.cgi?id=194811
Stat: 2017-03-12 https://bugzilla.kernel.org/show_bug.cgi?id=194811#c8
Note: patch likely heading mainline

Desc: [lkp-robot] [f2fs] 4ac912427c: -33.7% aim7.jobs-per-min regression
Repo: 2017-03-08 https://www.spinics.net/lists/kernel/msg2459239.html
Stat: 2017-03-13 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1353085.html
Note: patch discussed and heading mainline

Desc: VM with virtio-scsi drive often crashes during boot with kernel 4.11rc1
Repo: 2017-03-09 https://bugzilla.kernel.org/show_bug.cgi?id=194837
Stat: n/a 
Note: will forward this to scsi & virtio & kvm people

Desc: general protection fault: inet6_fill_ifaddr+0x6c/0x230
Repo: 2017-03-11 https://bugzilla.kernel.org/show_bug.cgi?id=194849
Stat: n/a 
Note: poked bug for status; might need to get forwared to network people

Desc: Synaptics RMI4 touchpad regression in 4.11-rc1
Repo: 2017-03-11 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1351561.html
Stat: 2017-03-13 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1352399.html
Note: solution discussed, no patch yet

Desc: DRM BUG while initializing cape verde (2nd card)
Repo: 2017-03-13 https://bugzilla.kernel.org/show_bug.cgi?id=194867
Stat: n/a 
Note: patch proposed by reporter
