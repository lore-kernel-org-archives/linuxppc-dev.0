Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78191679F8
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 13:12:15 +1000 (EST)
Subject: Re: ppc32 kernel boot problem (pmu related?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Pilatzke <nathanpilatzke@gmail.com>
In-Reply-To: <98889dd30605111207g6afe6158je681717ccacb9e40@mail.gmail.com>
References: <98889dd30605111207g6afe6158je681717ccacb9e40@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 12 May 2006 13:12:05 +1000
Message-Id: <1147403525.7343.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-11 at 15:07 -0400, Nathan Pilatzke wrote:
> Hello, I am not a member of this list and I hope this is the correct
> place to report such problems and ask for help.
> 
> I am running an eMac first generation powerpc (700MHz) and the Gentoo
> distribution.  Kernel 2.6.15 (Gentoo revision 1) is working quite well
> for me.  A few days ago I compiled 2.6.17-rc3 from the vanilla sources
> ebuild and am having troubles with the pmu code.
> 
> I can boot successfully when my config has
> # CONFIG_ADB_PMU is not set
> but cannot boot if my config has
> CONFIG_ADB_PMU=y

What happens when you enable that option ?

> I can post anything you need to help narrow down the problem (ie.
> kernel configs, boot msgs).  Would turning on the kernel debugging
> give more information on the problem?  Any help would be greatly
> appreciated... even if I can just narrow down the problem further so
> that I can make a very specific bug report.
> 
> Here is the cpuinfo (as reported under 2.6.17-rc3 without PMU):
> cat /proc/cpuinfo
> processor       : 0
> cpu             : 7450, altivec supported
> clock           : 700.000000MHz
> revision        : 0.1 (pvr 8000 0201)
> bogomips        : 49.79
> timebase        : 24913389
> platform        : PowerMac
> machine         : PowerMac4,4
> motherboard     : PowerMac4,4 MacRISC2 MacRISC Power Macintosh
> detected as     : 80 (eMac)
> pmac flags      : 00000010
> L2 cache        : 256K unified
> pmac-generation : NewWorld
> 
> Thanks.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
