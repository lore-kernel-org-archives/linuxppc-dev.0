Content-Type: text/plain;
  charset="us-ascii"
From: Armando Di Cianno <armando@nycap.rr.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: titanium 800mhz revIII sleep
Date: Fri, 13 Sep 2002 16:31:11 -0400
MIME-Version: 1.0
Message-Id: <200209131631.12013.armando@nycap.rr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know this post is more applicable to the linuxppc-user list; I tried there,
as well as RTFM, but I can't seem to figure this out.

Just wondering if any recent kernels have sleep working on the revIII
titanium powerbook?

I'm currently running:
- gentoo(gcc3.2, glibc2.2.5)
- kernel: 2.4.20-pre5-ben0 (running all the usual tibook modules)
- using "sysctl -w cpu.0.speed=800000" to set the cpufreq up to 800Mhz

If bits for a working sleep are not in any kernel yet, but are being/plan to
be worked on, I'll gladly offer my services and tibook as a test platform.

... some days I really wish I knew how to hack kernel space. :-)

Thanks for any info,
__armando di cianno


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
