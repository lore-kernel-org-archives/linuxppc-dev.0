Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB8E7@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: powerpc board without RTC
Date: Sun, 2 Feb 2003 15:32:51 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I had a custom 7410 board without RTC. Therefore, I commented out
time_init() in start_kernel(). Is this acceptable for linux ?

>From the startup log of linux, it hang in calibrate_delay() which I think
it is related to RTC.

Any recommendation how I should do to avoid RTC. I really don't care
about time of day stuff except the system tick.



Loading... 618940
Starting at 0x800000...

loaded at:     00800000 008971BC
zimage at:     00805870 00893F33
avail ram:     00400000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Total memory = 64MB; using 128kB for hash table (at c0180000)
Linux version 2.4.17_mvl21 (root@ibm-t30) (gcc version 2.95.3 20010315
(release/
MontaVista)) #41 Sun Feb 2 15:18:05 CST 2003
Host bridge init okay
Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
OpenPIC Version 1.2 (1 CPUs and 26 IRQ sources) at fdfd0000
Calibrating delay loop...



Thanks.

Bo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
