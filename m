Return-Path: <regressions@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6J5Y06yXzDvS8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 00:20:31 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.9: Reported regressions as of Sunday, 2016-10-30
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <0eb29167-7908-e049-6927-d9c6b093970d@leemhuis.info>
Date: Sun, 30 Oct 2016 14:20:25 +0100
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

Hi! Here is my second regression report for Linux 4.9. It lists 14
regressions I'm aware of. 4 of them are new; 3 got fixed since last weeks report.

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Desc: tpm0: TPM self test failed
Repo: 2016-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1259943.html
Stat: 2016-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1260452.html https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1256705.html 
Note: Fix hopefully soon heading upstream

Desc: Radeon Oops on shutdown
Repo: 2016-10-19 https://bugzilla.kernel.org/show_bug.cgi?id=178421
Stat: 2016-10-30 https://bugzilla.kernel.org/show_bug.cgi?id=178421#c6
Note: WIP

Desc: module loadling broken due to kbuild changes
Repo: 2016-10-15 http://www.gossamer-threads.com/lists/linux/kernel/2544734
Stat: 2016-10-27 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1259418.html
Note: Fix available, waiting for Michal to get back from vacation; wondering if those will fix https://bugzilla.kernel.org/show_bug.cgi?id=185581 and https://lkml.org/lkml/2016/10/27/471 and https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1250105.html as well

Desc: pci: artpec-6: imprecise external abort
Repo: 2016-10-14 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1249646.html
Stat: 2016-10-14 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1249922.html
Note: Patch available

Desc: PPC32: fails to boot on my PowerBook G4 Aluminum; bisected to commit 05fd007e4629
Repo: 2016-10-20 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253391.html
Stat: 2016-10-22 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255516.html https://www.linux-mips.org/archives/linux-mips/2016-10/msg00176.html https://lkml.org/lkml/2016/10/18/142
Note: Larry made a hack that works for him.

Desc: "Nokia N900 (omap3-n900) with ""VDD1: ramp_delay not set"" string in printk frequently"
Repo: 2016-10-19 https://bugzilla.kernel.org/show_bug.cgi?id=178371
Stat: n/a https://lkml.org/lkml/2016/10/27/527
Note: discussion on lkml ongoing

Desc: radeon performance drop from 4.8 to 4.9-rc1 in Shadow of Mordor
Repo: 2016-10-14 https://bugzilla.kernel.org/show_bug.cgi?id=178221 https://lists.freedesktop.org/archives/dri-devel/2016-October/120693.html
Stat: 2016-10-20 https://lists.freedesktop.org/archives/dri-devel/2016-October/121427.html
Note: Stuck? Poked bugzilla

Desc: unable to handle kernel NULL pointer dereference at fuse_setattr
Repo: 2016-10-17 https://bugzilla.kernel.org/show_bug.cgi?id=177801
Stat: 2016-10-18 https://bugzilla.kernel.org/show_bug.cgi?id=177801#c5
Note: Fix heading upstream

Desc: Skylake gen6 suspend/resume video regression
Repo: 2016-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177731
Stat: 2016-10-25 https://bugzilla.kernel.org/show_bug.cgi?id=177731#c3
Note: WIP

Desc: warning in intel_dp_aux_transfer: CPU: 0 PID: 4 at drivers/gpu/drm/i915/intel_dp.c:1062 intel_dp_aux_transfer+0x1ed/0x230#
Repo: 2016-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177701
Stat: 2016-10-27 https://bugs.freedesktop.org/show_bug.cgi?id=97344
Note: Poked Janni to give a statement

Desc: """Failed to find cpu0 device node"" in dmesg"
Repo: 2016-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177681 https://bugzilla.kernel.org/show_bug.cgi?id=180031
Stat: 2016-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1260133.html
Note: Patches afaics in the work

Desc: boot failure of Intel Mobile Internet Devices due to a change in the PCI subsystem that appeared in v4.9-rc1.
Repo: 2016-10-23 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255643.html
Stat: 2016-10-26 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1258579.html
Note: Fix proposed

Desc: 4.9-rc1 boot regression, ambiguous bisect result
Repo: 2016-10-19 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253369.html
Stat: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255296.html
Note: Poked list, as this looks stuck or was is discussed (or even fixed) somewhere else


== Stalled, waiting for feedback from reporter ==

Desc: can't boot with root fs on md raid 0; mdadm: no devices listed in conf file were found. 
Repo: 2016-10-17 https://bugzilla.kernel.org/show_bug.cgi?id=178211
Stat: 2016-10-18 https://bugzilla.kernel.org/show_bug.cgi?id=178211#c1
Note: Root cause unknown; might be a controller driver issue


== Going to be removed from the list ==

Desc: some gpio drivers broken by commit 762c2e46
Repo: 2016-10-18 https://www.spinics.net/lists/linux-gpio/msg17283.html
Stat: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253906.html
Note: Not a 4.9 regression


== Fixed since last report ==

Desc: "Regression with 0b9e2988ab22 (""ahci: use pci_alloc_irq_vectors"")"
Repo: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254825.html
Fix:  https://git.kernel.org/torvalds/c/17a51f12cfbd2814fd35966a069b242569c53e27 https://git.kernel.org/torvalds/c/0ce57f8af1782fd12d3a81872a4ab97244989802

Desc: 761ed4a94582 tty: serial_core: convert uart_close to use tty_port_close
Repo: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254753.html
Fix:  https://git.kernel.org/torvalds/c/d0f4bce2bce7e998abc906f3590e9032af7a41ba

Desc: [selinux/audit/netlink, regression?] Warning at kernel/softirq.c:161
Repo: 2016-10-20 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254148.html
Fix:  https://git.kernel.org/torvalds/c/2a73306b6096fafd5c2ae06ded1f92bbacb39df2
