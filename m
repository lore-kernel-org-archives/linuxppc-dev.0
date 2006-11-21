Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 87D5667D65
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 08:24:26 +1100 (EST)
Date: Tue, 21 Nov 2006 22:24:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.19-rc6: known regressions (v4)
Message-ID: <20061121212424.GQ5200@stusta.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Ernst Herzberg <earny@net4u.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andre Noll <maan@systemlinux.org>, linuxppc-dev@ozlabs.org,
	Vivek Goyal <vgoyal@in.ibm.com>, paulus@samba.org,
	Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>,
	Pavel Emelianov <xemul@openvz.org>,
	David Rientjes <rientjes@cs.washington.edu>,
	Sam Ravnborg <sam@mars.ravnborg.org>, phil.el@wanadoo.fr,
	David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org,
	oprofile-list@lists.sf.net, Phil Oester <kernel@linuxace.com>,
	Prakash Punnoor <prakash@punnoor.de>,
	Len Brown <len.brown@intel.com>, discuss@x86-64.org,
	cpufreq@lists.linux.org.uk, a.zummo@towertech.it,
	Mattia Dongili <malattia@linux.it>, ak@suse.de, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This email lists some known regressions in 2.6.19-rc6 compared to 2.6.18
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : kernel hangs when booting with irqpoll
References : http://lkml.org/lkml/2006/11/20/233
Submitter  : Vivek Goyal <vgoyal@in.ibm.com>
Caused-By  : Pavel Emelianov <xemul@openvz.org>
             commit f72fa707604c015a6625e80f269506032d5430dc
Handled-By : Vivek Goyal <vgoyal@in.ibm.com>
Status     : problem is being debugged


Subject    : x86_64: Bad page state in process 'swapper'
References : http://lkml.org/lkml/2006/11/10/135
             http://lkml.org/lkml/2006/11/10/208
Submitter  : Andre Noll <maan@systemlinux.org>
Handled-By : David Rientjes <rientjes@cs.washington.edu>
Status     : problem is being debugged


Subject    : x86_64: oprofile doesn't work
References : http://lkml.org/lkml/2006/10/27/3
             http://lkml.org/lkml/2006/11/15/92
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : problem is being discussed


Subject    : ACPI: AE_TIME errors
References : http://lkml.org/lkml/2006/11/15/12
Submitter  : David Brownell <david-b@pacbell.net>
Handled-By : Len Brown <len.brown@intel.com>
             Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Status     : problem is being debugged


Subject    : ThinkPad R50p: boot fail with (lapic && on_battery)
References : http://lkml.org/lkml/2006/10/31/333
Submitter  : Ernst Herzberg <earny@net4u.de>
Handled-By : Len Brown <len.brown@intel.com>
Status     : problem is being debugged


Subject    : powerpc: serious RTC problems
References : http://lkml.org/lkml/2006/11/17/187
             http://lkml.org/lkml/2006/11/18/99
Submitter  : Kumar Gala <galak@kernel.crashing.org>
             Joakim Tjernlund <joakim.tjernlund@transmode.se>
Caused-By  : Kim Phillips <kim.phillips@freescale.com>
             commit 7a69af63e788a324d162201a0b23df41bcf158dd
             commit a8ed4f7ec3aa472134d7de6176f823b2667e450b
Handled-By : David Brownell <david-b@pacbell.net
             Kim Phillips <kim.phillips@freescale.com>
Patch      : http://lkml.org/lkml/2006/11/20/320
             http://lkml.org/lkml/2006/11/20/321
Status     : patches available


Subject    : xconfig crashes on x86_64
References : http://lkml.org/lkml/2006/11/19/177
Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
Handled-By : Roman Zippel <zippel@linux-m68k.org>
Patch      : http://lkml.org/lkml/2006/11/20/340
Status     : patch available


Subject    : menuconfig problems with TERM=vt100
References : http://lkml.org/lkml/2006/11/13/369
Submitter  : Phil Oester <kernel@linuxace.com>
Caused-By  : Sam Ravnborg <sam@mars.ravnborg.org>
             commit 350b5b76384e77bcc58217f00455fdbec5cac594
Handled-By : Roman Zippel <zippel@linux-m68k.org>
Patch      : http://lkml.org/lkml/2006/11/20/341
Status     : patch available


Subject    : CPU_FREQ_GOV_ONDEMAND=y compile error
References : http://lkml.org/lkml/2006/11/17/198
Submitter  : alex1000@comcast.net
Caused-By  : Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
             commit 05ca0350e8caa91a5ec9961c585c98005b6934ea
Handled-By : Mattia Dongili <malattia@linux.it>
Patch      : http://lkml.org/lkml/2006/11/17/236
Status     : patch available
