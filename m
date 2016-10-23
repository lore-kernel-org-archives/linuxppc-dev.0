Return-Path: <regressions@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t21rP71CszDvWv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 01:24:19 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.9: Reported regressions as of Sunday, 2016-10-23
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <369dcbd1-8cfa-3914-3bab-769dc5d794ab@leemhuis.info>
Date: Sun, 23 Oct 2016 16:24:13 +0200
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

Hi! Here is my first regression report for Linux 4.9. It lists 14
regressions I'm aware of. 
 
As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: I ran out of time today (I really need to automate some things, 
but I do not find time for it…; and some of the regression tracking work 
simply can not be automated :/) and could not make it completely 
through my backlog. That's why I likely missed lots of regressions 
that were reported during the merge window and remain unfixed as of now 
:-/ Let me know about those, please.

== Current regressions ==

Desc: PPC32: fails to boot on my PowerBook G4 Aluminum; bisected to commit 05fd007e4629
Repo: 2016-10-20 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253391.html
Stat: 2016-10-22 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255516.html
Note: no response from responsible developers yet

Desc: "Nokia N900 (omap3-n900) with ""VDD1: ramp_delay not set"" string in printk frequently"
Repo: 2016-10-19 https://bugzilla.kernel.org/show_bug.cgi?id=178371
Stat: n/a 
Note: told reporter whom to contact

Desc: radeon performance drop from 4.8 to 4.9-rc1 in Shadow of Mordor
Repo: 2016-10-14 https://bugzilla.kernel.org/show_bug.cgi?id=178221 https://lists.freedesktop.org/archives/dri-devel/2016-October/120693.html
Stat: 2016-10-20 https://lists.freedesktop.org/archives/dri-devel/2016-October/121427.html
Note: WIP

Desc: can't boot with root fs on md raid 0; mdadm: no devices listed in conf file were found. 
Repo: 2016-10-17 https://bugzilla.kernel.org/show_bug.cgi?id=178211
Stat: 2016-10-18 https://bugzilla.kernel.org/show_bug.cgi?id=178211#c1
Note: Root cause unknown; might be a controller driver issue

Desc: unable to handle kernel NULL pointer dereference at fuse_setattr
Repo: 2016-10-17 https://bugzilla.kernel.org/show_bug.cgi?id=177801
Stat: 2016-10-18 https://bugzilla.kernel.org/show_bug.cgi?id=177801#c5
Note: Fix heading upstream

Desc: Skylake gen6 suspend/resume video regression
Repo: 2016-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177731
Stat: n/a 
Note: 

Desc: warning in intel_dp_aux_transfer: CPU: 0 PID: 4 at drivers/gpu/drm/i915/intel_dp.c:1062 intel_dp_aux_transfer+0x1ed/0x230#
Repo: 2016-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177701
Stat: n/a 
Note: 

Desc: """Failed to find cpu0 device node"" in dmesg"
Repo: 2016-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177681 https://bugzilla.kernel.org/show_bug.cgi?id=180031
Stat: n/a 
Note: 

Desc: boot failure of Intel Mobile Internet Devices due to a change in the PCI subsystem that appeared in v4.9-rc1.
Repo: 2016-10-23 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255643.html
Stat: n/a 
Note: Fix proposed

Desc: "Regression with 0b9e2988ab22 (""ahci: use pci_alloc_irq_vectors"")"
Repo: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254825.html
Stat: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254882.html
Note: WIP

Desc: 761ed4a94582 tty: serial_core: convert uart_close to use tty_port_close
Repo: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254753.html
Stat: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254987.html
Note: WIP

Desc: [selinux/audit/netlink, regression?] Warning at kernel/softirq.c:161
Repo: 2016-10-20 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254148.html
Stat: 2016-10-20 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254151.html https://patchwork.ozlabs.org/patch/684753/
Note: WIP

Desc: some gpio drivers broken by commit 762c2e46
Repo: 2016-10-18 https://www.spinics.net/lists/linux-gpio/msg17283.html
Stat: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253906.html
Note: WIP

Desc: 4.9-rc1 boot regression, ambiguous bisect result
Repo: 2016-10-19 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253369.html
Stat: 2016-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255296.html
Note: WIP
