Return-Path: <freeserj@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 44A4667D5D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2005 08:10:50 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i28so43312wra
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2005 15:10:49 -0700 (PDT)
Message-ID: <d39e2e70507261510edd0e8@mail.gmail.com>
Date: Wed, 27 Jul 2005 02:10:49 +0400
From: Sergey Kolosov <freeserj@gmail.com>
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: cpufreq on powerbook lombard
Reply-To: Sergey Kolosov <freeserj@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

How i can enabled cpufreq on my powerbook lombard? In kernel(2.6.11) source=
:

file /usr/src/kernel-source-2.6.11/arch/ppc/platforms/pmac_cpufreq.c

<...>
/* Currently, we support the following machines:
 *
 *  - Titanium PowerBook 1Ghz (PMU based, 667Mhz & 1Ghz)
 *  - Titanium PowerBook 800 (PMU based, 667Mhz & 800Mhz)
 *  - Titanium PowerBook 400 (PMU based, 300Mhz & 400Mhz)
 *  - Titanium PowerBook 500 (PMU based, 300Mhz & 500Mhz)
 *  - iBook2 500/600 (PMU based, 400Mhz & 500/600Mhz)
 *  - iBook2 700 (CPU based, 400Mhz & 700Mhz, support low voltage)
 *  - Recent MacRISC3 laptops
 *  - iBook G4s and PowerBook G4s with 7447A CPUs
 */
static int __init pmac_cpufreq_setup(void)
<...>

 But can be there is a way for addition of support cpufreq for
powerbook lombard ?

P.S.
sk@powerbook:~$ cat /proc/cpuinfo
processor       : 0
cpu             : 740/750
temperature     : 74-76 C (uncalibrated)
clock           : 333MHz
revision        : 131.0 (pvr 0008 8300)
bogomips        : 665.60
machine         : PowerBook1,1
motherboard     : PowerBook1,1 MacRISC Power Macintosh
detected as     : 64 (PowerBook 101 (Lombard))
pmac flags      : 00000009
L2 cache        : 512K unified
memory          : 256MB
pmac-generation : NewWorld
sk@powerbook:~$ uname -a
Linux powerbook 2.6.8-powerpc #1 Sun Mar 20 14:09:41 CET 2005 ppc GNU/Linux
sk@powerbook:~$ cat /etc/debian_version
3.1
