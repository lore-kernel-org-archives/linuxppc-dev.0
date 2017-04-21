Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8cx51DByzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 00:06:47 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.11: Reported regressions as of Friday, 2017-04-21
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <973bd914-3b19-5b10-90ea-b86e3715ca98@leemhuis.info>
Date: Fri, 21 Apr 2017 16:06:40 +0200
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

Hi! Find below my fourth regression report for Linux 4.11. It lists 10
regressions I'm currently aware of. 7 regressions mentioned in last
weeks report got fixed.

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Thx to all those that CCed me on regression reports or provided
other input, it makes compiling these reports a whole lot easier!

== Current regressions ==

Desc: Client system gets spammed with 'NFSv4 Callback' kthreads - eventually causing NFS shares to become unresponsive
Repo: 2017-04-17 https://bugzilla.kernel.org/show_bug.cgi?id=195449
Stat: n/a 
Note: quite new, needs to get forwarded to the network people

Desc: boot problems when virtio-scsi is used
Repo: 2017-04-19 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1380561.html
Stat: 2017-04-20 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1381637.html
Note: patch heading mainline

Desc: unable to handle kernel NULL pointer dereference, mtip_irq_handler+0x262/0x3c0 [mtip32xx]
Repo: 2017-04-12 https://bugzilla.kernel.org/show_bug.cgi?id=195429
Stat: n/a 
Note: not entirely clear if this is a regression, but bhelgaas is looking into it

Desc: tytso: systemd doesn't see most devices
Repo: 2017-04-11 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1375255.html
Stat: 2017-04-12 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1375851.html
Note: heisenbug?

Desc: crash since 617f01211baf ("8139too: use napi_complete_done()")
Repo: 2017-04-07 https://www.mail-archive.com/netdev@vger.kernel.org/msg162162.html
Stat: 2017-04-08 https://www.mail-archive.com/netdev@vger.kernel.org/msg162285.html
Note: there is a patch in that thread, but it afaics is not heading mainline and the discussion stalled

Desc: Busy softirq can cause userspace not to be scheduled
Repo: 2017-03-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1363884.html 
Stat: 2017-04-20 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1381585.html
Note: Frederic: "working on reproducing that one"

Desc: Commit d8514d8edb5b ("ovl: copy up regular file using O_TMPFILE") breaks ubifs
Repo: 2017-03-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1363879.html
Stat: 2017-04-17 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1378740.html
Note: Patch hopefully heading upstream soon

Desc: pine64 defconfig: WARNING: CPU: 0 PID: 86 at drivers/base/dd.c:349 driver_probe_device+0x258/0x2c0
Repo: 2017-03-25 https://bugzilla.kernel.org/show_bug.cgi?id=195037 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1368488.html
Stat: 2017-04-18 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1379209.html
Note: André doesnt have a clue and needs someone with insights devm and devres; seems to be gone in -next

Desc: NVMe APST: Samsung NVMe sudden controller death
Repo: 2017-03-18 https://bugzilla.kernel.org/show_bug.cgi?id=195039 https://bugzilla.kernel.org/show_bug.cgi?id=194921
Stat: 2017-04-20 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1381954.html
Note: blacklist update heading mainline 

Desc: Perf regression after enabling nvme APST
Repo: 2017-03-17 https://lkml.org/lkml/2017/3/17/177
Stat: 2017-04-20 https://lkml.org/lkml/2017/3/20/998
Note: stalled


== Stalled, waiting for feedback from reporter ==

Desc: kvm: workqueue lockup
Repo: 2017-03-14 https://bugzilla.kernel.org/show_bug.cgi?id=194883
Stat: 2017-03-27 https://bugzilla.kernel.org/show_bug.cgi?id=194883#c1
Note: asked reporter if issue still present in RC4

Desc: general protection fault: inet6_fill_ifaddr+0x6c/0x230
Repo: 2017-03-11 https://bugzilla.kernel.org/show_bug.cgi?id=194849
Stat: 2017-03-13 https://bugzilla.kernel.org/show_bug.cgi?id=194849#c1
Note: Cong Wang asked reporter for details, didn't get any reply yet

Desc: 4.11 PowerMac G5 970MP: [drm:.r600_ring_test [radeon]] *ERROR* radeon: ring 0 test failed (scratch(0x8504)=0xCAFEDEAD
Repo: 2017-03-24 https://bugs.freedesktop.org/show_bug.cgi?id=99851#c26
Stat: n/a 
Note: stalled; looks like reporter (who does not see the problem in 4.10) could need some help bisecting


== Going to be removed from the list ==

Desc: i915 gpu hangs under load (2)
Repo: 2017-03-22 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1372182.html
Stat: 2017-04-07 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1372182.html
Note: Andrea saw issues and sent some patches that were discussed; some were applied, others discussed, but then the discussion stalled;  I assume it's fixed, as Andrea knows how all this works

Desc: Warning since RC4: sed_opal:OPAL: Error on step function: 0 with error -95: Unknown Error
Repo: 2017-04-07 https://bugzilla.kernel.org/show_bug.cgi?id=195277
Stat: 2017-04-07 https://www.spinics.net/lists/linux-block/msg11136.html
Note: Applied for 4.12


== Fixed since last report ==

Desc: i915 gpu hangs under load (1)
Repo: 2017-03-22 https://www.mail-archive.com/intel-gfx@lists.freedesktop.org/msg116227.html https://bugs.freedesktop.org/show_bug.cgi?id=100181
Stat: 2017-04-10 https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg182641.html https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1373328.html
Note: Fixed, according to Chris and the reporter (sorry for getting this wrong in the last report, that bug trail was hard to follow from the outside)

Desc: Problems since 5b52330bbfe6 "audit: fix auditd/kernel connection state tracking"
Repo: 2017-04-09 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1373243.html
Fix:  https://git.kernel.org/torvalds/c/264d509637d95f9404e52ced5003ad352e0f6a26

Desc: Synaptics RMI4 touchpad regression in 4.11-rc1: pointer jumps
Repo: 2017-03-11 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1351561.html
Fix:  https://git.kernel.org/torvalds/c/84379d83d8e536aef2c706744ff22c136d0be6c9

Desc: Synaptics RMI4 touchpad regression in 4.11-rc1: palm detection
Repo: 2017-03-11 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1351561.html
Fix:  https://git.kernel.org/torvalds/c/84379d83d8e536aef2c706744ff22c136d0be6c9

Desc: "Synaptics Touch Digitizer V04" no longer working
Repo: 2017-04-08 https://bugzilla.kernel.org/show_bug.cgi?id=195287
Fix:  https://git.kernel.org/torvalds/c/84379d83d8e536aef2c706744ff22c136d0be6c9

Desc: networking/softirq performance regression due to a part of 374ad05ab64d
Repo: 2017-03-29 https://lkml.org/lkml/2017/3/29/758
Fix:  https://git.kernel.org/torvalds/c/d34b0733b452ca3ef1dee36436dab08b8aa6a85c

Desc: 07ec51480b5e  ("virtio_pci: use shared interrupts for virtqueues") causes some kworker grief in -rt too
Repo: 2017-03-27 https://www.mail-archive.com/search?l=mid&q=1490605644.14634.50.camel@gmx.de
Fix:  https://git.kernel.org/torvalds/c/787393338557456d2ad2dd49c45080624e39cbe5
