Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id A3407DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 08:28:23 +1100 (EST)
Date: Mon, 24 Nov 2008 15:19:54 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] hide attr_smt_snooze_delay reference with CONFIG_PPC64
Message-ID: <20081124211954.GE6830@localdomain>
References: <3122687188274b0dc514.424238335.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3122687188274b0dc514.424238335.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> attr_smt_snooze_delay is defined for CONFIG_PPC64, so protect the attribute
> removal with the same condition.
> 
> /data/home/miltonm/next.git/arch/powerpc/kernel/sysfs.c: In function ‘unregister_cpu_online’:
> /data/home/miltonm/next.git/arch/powerpc/kernel/sysfs.c:722: error: ‘attr_smt_snooze_delay’ undeclared (first use in this function)
> /data/home/miltonm/next.git/arch/powerpc/kernel/sysfs.c:722: error: (Each undeclared identifier is reported only once
> /data/home/miltonm/next.git/arch/powerpc/kernel/sysfs.c:722: error: for each function it appears in.)

Is this one going in?  The build is also broken for powermac 32-bit
SMP with HOTPLUG_CPU=y (which I can't figure out how to turn off,
grr).  And this isn't confined to -next; mainline is broken too.
