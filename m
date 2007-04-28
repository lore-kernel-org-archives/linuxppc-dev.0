Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82E1CDDF5F
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 18:38:18 +1000 (EST)
Subject: Re: [PATCH] powermac: proper sleep management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1177746562.3448.10.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
Content-Type: text/plain
Date: Sat, 28 Apr 2007 18:38:11 +1000
Message-Id: <1177749491.14873.348.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-04-28 at 09:49 +0200, Johannes Berg wrote:
> After having removed the power management ops from powermac completely, this
> patch adds them back for PMU based machines, directly in the PMU driver.
> This finally allows suspending via /sys/power/state on powerbooks.
> 
> The patch also replaces the PMU ioctl with a simple call to
> pm_suspend(PM_SUSPEND_MEM) and puts the sleep-related PMU ioctls onto the
> feature-removal schedule.

What happened to moving that code out of the PMU driver ?

Cheers,
Ben.
