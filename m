Return-Path: <nathanpilatzke@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.194])
	by ozlabs.org (Postfix) with ESMTP id 06D9A679F7
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 05:14:10 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id x7so254009nzc
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 12:14:09 -0700 (PDT)
Message-ID: <98889dd30605111207g6afe6158je681717ccacb9e40@mail.gmail.com>
Date: Thu, 11 May 2006 15:07:39 -0400
From: "Nathan Pilatzke" <nathanpilatzke@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: ppc32 kernel boot problem (pmu related?)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I am not a member of this list and I hope this is the correct
place to report such problems and ask for help.

I am running an eMac first generation powerpc (700MHz) and the Gentoo
distribution.  Kernel 2.6.15 (Gentoo revision 1) is working quite well
for me.  A few days ago I compiled 2.6.17-rc3 from the vanilla sources
ebuild and am having troubles with the pmu code.

I can boot successfully when my config has
# CONFIG_ADB_PMU is not set
but cannot boot if my config has
CONFIG_ADB_PMU=3Dy

I can post anything you need to help narrow down the problem (ie.
kernel configs, boot msgs).  Would turning on the kernel debugging
give more information on the problem?  Any help would be greatly
appreciated... even if I can just narrow down the problem further so
that I can make a very specific bug report.

Here is the cpuinfo (as reported under 2.6.17-rc3 without PMU):
cat /proc/cpuinfo
processor       : 0
cpu             : 7450, altivec supported
clock           : 700.000000MHz
revision        : 0.1 (pvr 8000 0201)
bogomips        : 49.79
timebase        : 24913389
platform        : PowerMac
machine         : PowerMac4,4
motherboard     : PowerMac4,4 MacRISC2 MacRISC Power Macintosh
detected as     : 80 (eMac)
pmac flags      : 00000010
L2 cache        : 256K unified
pmac-generation : NewWorld

Thanks.
