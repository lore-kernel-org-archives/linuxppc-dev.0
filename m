From: "Michael Fischer" <fischi@epygi.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Memory optimization of diskless system
Date: Thu, 9 Aug 2001 16:49:56 +0200
Message-ID: <OEEHJMIIDJHHMFGGDNGDCEPACEAA.fischi@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
i have a Linuxppc Kernel 2.4.8 pre 4 running on a motorola asd8260 board
(16M ram). When using initrd and ramdisk to boot the system i run into out
of memory problems.
proc/meminfo shows:

        total:    used:    free:  shared: buffers:  cached:
Mem:  14958592 12062720  2895872  7421952  6656000  2191360
Swap:        0        0        0
MemTotal:        14608 kB
MemFree:          2828 kB
MemShared:        7248 kB
Buffers:          6500 kB
Cached:           2140 kB
Active:           8640 kB
Inact_dirty:         0 kB
Inact_clean:         0 kB
Inact_target:       12 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        14608 kB
LowFree:          2828 kB
SwapTotal:           0 kB
SwapFree:            0 kB

is it really necessary to have so many buffers allocated and if not, how can
i change the amount?
(i already tried to change the values in /proc/sys/vm/buffermem without any
success).
Also other ideas how to optimize the ram usage are highly appreciated.

Thanks a lot for your input,
Michael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
