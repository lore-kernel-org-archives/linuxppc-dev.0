Message-ID: <37339E39.F174BE46@iwate-u.ac.jp>
Date: Sat, 08 May 1999 12:15:21 +1000
From: Piotr Muszynski <u0295020@iwate-u.ac.jp>
MIME-Version: 1.0
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Vger 2.2.7 and console
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The text console seems broken in latest (updated yesterday) vger kernel
2.2.7.  On boot,  Tux appears 2/3 to the right and text scrolls to the
left side of display.  It's readable,  just a bit difficult to become
used to :-)
Previous version as of May 4th was OK.  I'm on PMac7500/100 if that
matters.
How can I help?  Any ideas of a fix?

piotru

...
May  8 11:49:35 piotr syslogd 1.3-3: restart.
May  8 11:49:35 piotr kernel: klogd 1.3-3, log source = /proc/kmsg
started.
May  8 11:49:37 piotr kernel: Loaded 10598 symbols from
/usr/src/linux/System.map.
May  8 11:49:37 piotr kernel: Symbols match kernel version 2.2.7.
May  8 11:49:37 piotr kernel: No module symbols loaded.
May  8 11:49:37 piotr kernel: device tree used 15544 bytes
May  8 11:49:37 piotr kernel: Total memory = 64MB; using 256kB for hash
table (at c01c0000)
May  8 11:49:37 piotr kernel: Linux version 2.2.7
(piotr@piotr.agr.iwate-u.ac.jp) (gcc version egcs-2.90.25 980302
(egcs-1.0.2 prerelease)) #1 Fri May 7 23:32:46 YAPT 1999
May  8 11:49:37 piotr kernel: PCI bus 0 controlled by bandit at f2000000

May  8 11:49:37 piotr kernel: Cache coherency enabled for bandit/PSX at
f2000000
May  8 11:49:37 piotr kernel: PCI bus 1 controlled by chaos at f0000000
May  8 11:49:37 piotr kernel: System has 32 possible interrupts
May  8 11:49:37 piotr kernel: Console: colour dummy device 80x25
May  8 11:49:37 piotr kernel: Calibrating delay loop... 99.53 BogoMIPS
May  8 11:49:37 piotr kernel: Memory: 62944k available (940k kernel
code, 1564k data, 88k init) [c0000000,c4000000]
May  8 11:49:37 piotr kernel: POSIX conformance testing by UNIFIX
May  8 11:49:37 piotr kernel: PCI: Probing PCI hardware
May  8 11:49:37 piotr kernel: Linux NET4.0 for Linux 2.2
May  8 11:49:37 piotr kernel: Based upon Swansea University Computer
Society NET3.039
May  8 11:49:37 piotr kernel: NET4: Unix domain sockets 1.0 for Linux
NET4.0.
May  8 11:49:37 piotr kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May  8 11:49:37 piotr kernel: IP Protocols: ICMP, UDP, TCP, IGMP
May  8 11:49:37 piotr kernel: Starting kswapd v 1.5
May  8 11:49:37 piotr kernel: MacOS display is /chaos/control
May  8 11:49:37 piotr kernel: Using unsupported 1024x768 control at
94e00210, depth=16, pitch=2080
May  8 11:49:37 piotr kernel: Console: switching to colour frame buffer
device 128x48
May  8 11:49:37 piotr kernel: fb0: Open Firmware frame buffer device on
/chaos/control
May  8 11:49:37 piotr kernel: ADB keyboard at 2, handler set to 5
...



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
