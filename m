Message-ID: <3B4ECAD2.171244A@wtal.de>
Date: Fri, 13 Jul 2001 12:17:54 +0200
From: Jacek Jakubowski <jacek@wtal.de>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: benh last rsync don't compile
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In last rsync from benh at 13 Juli
on an iBook with no SMP support configured I get following compile
error:


In file included from /usr/src/benh_kernel/include/linux/interrupt.h:45,
                 from ksyms.c:21:
/usr/src/benh_kernel/include/asm/hardirq.h:45: warning:
`synchronize_irq' redefined
/usr/src/benh_kernel/include/linux/modules/ppc_ksyms.ver:184: warning:
this is the location of the previous definition
In file included from ksyms.c:17:
/usr/src/benh_kernel/include/linux/kernel_stat.h: In function
`kstat_irqs':
/usr/src/benh_kernel/include/linux/kernel_stat.h:48: `smp_num_cpus'
undeclared (first use in this function)


But I have 2.4.6 from rsync at 10 July running relatiely stable. I have
only an RTC proble:

while booting the rtc driver says:
Setting up the CMOS clockUnknown architecture (currently supported:
CHRP, PREP)
Unknown architecture (currently supported: CHRP, PREP)

There are any ideas?

Jacek Jakubowski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
