From: Joe Green <jgreen@mvista.com>
To: "Michael Fischer" <fischi@epygi.de>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Memory optimization of diskless system
Date: Thu, 9 Aug 2001 09:33:46 -0700
Content-Type: text/plain
References: <OEEHJMIIDJHHMFGGDNGDCEPACEAA.fischi@epygi.de>
In-Reply-To: <OEEHJMIIDJHHMFGGDNGDCEPACEAA.fischi@epygi.de>
MIME-Version: 1.0
Message-Id: <01080909352601.18546@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Fischer wrote:
> i have a Linuxppc Kernel 2.4.8 pre 4 running on a motorola asd8260 board
> (16M ram). When using initrd and ramdisk to boot the system i run into out
> of memory problems.
> proc/meminfo shows:
>
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  14958592 12062720  2895872  7421952  6656000  2191360
> Swap:        0        0        0
> MemTotal:        14608 kB
> MemFree:          2828 kB
> MemShared:        7248 kB
> Buffers:          6500 kB
> Cached:           2140 kB
> Active:           8640 kB
> Inact_dirty:         0 kB
> Inact_clean:         0 kB
> Inact_target:       12 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:        14608 kB
> LowFree:          2828 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
>
> is it really necessary to have so many buffers allocated and if not, how can
> i change the amount?

How big is you ramdisk?  That's included in the buffers.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
