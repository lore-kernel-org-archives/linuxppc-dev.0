Return-Path: <MCarey@nearfield.com>
Received: from webmail.nearfield.com (webmail.nearfield.com [63.200.6.70])
	by ozlabs.org (Postfix) with ESMTP id 38B0267B84
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 10:32:39 +1000 (EST)
Message-Id: <44D22E43020000710000243E@webmail.nearfield.com>
Date: Thu, 03 Aug 2006 17:11:31 -0700
From: "Michael Carey" <MCarey@nearfield.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: ELDK 3.1.1 support for x86_64 host architecture
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I found the subject "ELDK 3.1.1 support for x86_64 host architecture" in =
the archives (Apr 15 2005) which describes my problem, however there was =
never any posting of a resolution.

When I attempt to run: "./install -d /opt/eldk" I get the following =
output:

Do you really want to install into /opt/eldk directory[y/n]?: y

Creating directories
Done
Installing cross RPMs

Preparing...                ########################################### =
[100%]
        package rpm-4.1.1-1.8xa_10 is intended for a i386 architecture
can't change dir: No such file or directory

The details on my system are:

mcarey@mmtdev:~> cat /etc/issue

Welcome to SUSE LINUX 10.1 (X86-64) - Kernel \r (\l).

mcarey@mmtdev:~> uname -a
Linux mmtdev 2.6.16.13-4-default #1 Wed May 3 04:53:23 UTC 2006 x86_64 =
x86_64 x86_64 GNU/Linux
mcarey@mmtdev:~> cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :               Intel(R) Pentium(R) 4 CPU 3.06GHz
stepping        : 1
cpu MHz         : 3065.612
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm =
constant_tsc pni monitor ds_cpl tm2 cid cx16 xtpr
bogomips        : 6140.72
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

//
Thanks for any help you could provide,
Michael Carey
