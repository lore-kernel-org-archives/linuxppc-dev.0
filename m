Date: Thu, 6 Dec 2001 18:07:55 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: HIGHMEM + serial console + SMP + 2GB freeze on pmac
Message-ID: <20011206180754.A23942@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just compiled the latest 2_4_devel with CONFIG_SMP,
CONFIG_SERIAL_CONSOLE, CONFIG_XMON, and CONFIG_HIGHMEM, and I'm running
into some problems.

This machine is an ealier Sawtooth G4 (7400) with 4 memory slots and 2GB
of ram (I know, Macos does not support this).

First, It booted up normally, but when I logged into KDE it got about
halfway through the login and froze.

Then I booted with 'console=ttyS0,38400'.. it froze after

smp_core99_probe: found 1 cpus
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: Probing PCI hardware

Then I tried 'console=ttyS0,38400, mem=1500M'.. still died on probing PCI
hardware.

I'm going to try several other combinations of things, including taking
one memory stick out since this could actually be that the hardware
doesn't like that much memory.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
