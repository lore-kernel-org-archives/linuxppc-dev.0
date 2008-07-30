Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (mail.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 516FDDE507
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jul 2008 01:11:15 +1000 (EST)
Subject: RT-Preemption Kernel 2.6.25
From: Darcy Watkins <dwatkins@tranzeo.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 07:59:09 -0700
Message-Id: <1217429949.18914.117.camel@localhost>
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

I noticed an RT-Preemption patch for kernel 2.6.26 (brand new) and
updates to the RT-Preemption patch for kernel 2.6.24.

Does anyone know what the state is regarding kernel 2.6.25 and whether
or not an updated RT-Preemption patch will soon be released for it?

I am using RT-Preemption with kernel 2.6.25 on a PPC405EP and experience
mysterious exceptions involving rt_spinlock_slow_lock() when my system
gets loaded to the point where the CPU becomes saturated.  I want to
update and retest before diving in further.

Also, someone please point me to where email discussion, change logs,
etc are kept for RT-Preemption.  I only find patches at kernel.org, not
project info.  I'd like to be able to see change descriptions related to
patch updates (at least the updates related to development / maintenance
- I know some patch changes are just to keep sync with the kernel
development itself).

Thanks in advance.


-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
