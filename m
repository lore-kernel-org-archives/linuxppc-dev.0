Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90EADDDFA4
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:31:34 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3SFVThX009217
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 08:31:29 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3SFVSug021794
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 10:31:28 -0500 (CDT)
Date: Mon, 28 Apr 2008 10:31:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: filenames with spaces in /sys?
Message-ID: <20080428153127.GA9849@ld0162-tx32.am.freescale.net>
References: <alpine.DEB.1.10.0804272012000.11017@sheep.housecafe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0804272012000.11017@sheep.housecafe.de>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 27, 2008 at 08:35:51PM +0200, Christian Kujau wrote:
> I was a bit puzzled today when I came across
> /sys/devices/platform/pmu-battery.0/power_supply/PMU battery 0/power
> and thought to myself: why are there spaces in "PMU battery 0"?

Why not?

> Wouldn't ../pmu-battery.0/power_supply/PMU_battery_0/power be feasible too? 

Feasible, yes, but uglier, and as you point out, changing it now would
risk breaking userspace for little gain.

> I find it rather annoying to special case the spaces whenever to look
> for something in /sys, when I'm so used not to when doing the same
> find/grep/xargs stuff in /usr/src/linux.

If userspace tools make it awkward to deal with filenames with spaces,
let's fix the userspace tools.  /sys is certainly not the only place
they'll be found, and waging war against them is a battle best left for
a couple decades ago.

-Scott
