Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B94167A33
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Apr 2005 16:10:49 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 16:06:23 +1000
Message-Id: <1112594783.26086.22.camel@gaston>
Mime-Version: 1.0
Subject: iBook G3 owners
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

There have been various reports of issues with sleep among others on
iBook G3 equiped with the 750FX processor. Also, the cpufreq code on
these so far didn't change the CPU voltage, which limited the actual
power saving at low frequency.

I have uploaded various patches that should help fix these issues. Those
patches are all against current linus bk and they should be all applied
in the order below.

I would really appreciate some tests as I don't have access to any of
these machines. I need to know if cpufreq works reliably with those
patches and if the new voltage control makes any differnece on battery
life (check power consumption in /proc/pmu/battery_*/current when
running on battery) and I need to know if the patches are improving
reliability of sleep/wakeup.

The 4 patches can be found at these URLs. If you had earlier versions of
some of these, those patches replace them:

http://gate.crahsing.org/~benh/ppc32-750-errata-fix.diff
http://gate.crahsing.org/~benh/ppc32-pmac-sleep-fix.diff
http://gate.crahsing.org/~benh/cpufreq-add-suspend.diff
http://gate.crahsing.org/~benh/ppc32-cpufreq-gpio-off.diff

Please, let me know asap,

Ben.
