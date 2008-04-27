Return-Path: <SRS0+25f536c062cdd3c352bb+1708+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E1B9DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 04:54:45 +1000 (EST)
Subject: Re: filenames with spaces in /sys?
From: David Woodhouse <dwmw2@infradead.org>
To: Christian Kujau <lists@nerdbynature.de>
In-Reply-To: <alpine.DEB.1.10.0804272012000.11017@sheep.housecafe.de>
References: <alpine.DEB.1.10.0804272012000.11017@sheep.housecafe.de>
Content-Type: text/plain
Date: Sun, 27 Apr 2008 19:54:38 +0100
Message-Id: <1209322478.25560.84.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-04-27 at 20:35 +0200, Christian Kujau wrote:
> 
> /sys/devices/platform/pmu-battery.0/power_supply/PMU battery 0
> /sys/devices/platform/pmu-battery.0/power_supply/PMU battery 0/power
> 
> Hm, OTOH /proc also does contain some elements with spaces in it (e.g. 
> /proc/irq/47/GPIO1 ADB)...so, in short: would patches be accepted to
> turn ' ' into '_' again (if they don't break too much userspace stuff)?

I see no reason not to for the battery class, certainly.

-- 
dwmw2
