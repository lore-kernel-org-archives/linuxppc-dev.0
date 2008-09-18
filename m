Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (isa.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 11761DE038
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 23:46:22 +1000 (EST)
Subject: "neigh: timer & !nud_in_timer" warning
From: Darcy Watkins <dwatkins@tranzeo.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Thu, 18 Sep 2008 06:46:19 -0700
Message-Id: <1221745579.3326.3.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

In line 785 of net/core/neighbour.c is the following warning sometimes
output when a neighbour timer goes off.

		printk(KERN_WARNING "neigh: timer & !nud_in_timer\n");

I saw this warning yesterday.

Does anyone understand its significance?  My system is kernel 2.5.25.13
with RT preemption patch rt7 running on AMCC PPC405EP (not an SMP
system).



-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
