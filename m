Subject: Re: Dynamic lib loading & memory question
From: Jeff Angielski <jangiels@speakeasy.net>
To: "Smith, Craig" <Craig.Smith@icn.siemens.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <EA78B62757AF1E4799828249310AC4CA04E09F03@stca206a.bus.sc.rolm.com>
References: 
	 <EA78B62757AF1E4799828249310AC4CA04E09F03@stca206a.bus.sc.rolm.com>
Content-Type: text/plain
Message-Id: <1088119724.4208.3.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 24 Jun 2004 19:28:44 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-06-24 at 17:58, Smith, Craig wrote:

> Memory: 14112k available (1564k kernel code, 436k data, 68k init, 0k
> highmem)

<snip>

> ########################################
> root@raptorlinux->~ [2] cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  14520320  4505600 10014720        0        0  2531328
> Swap:        0        0        0
> MemTotal:        14180 kB
> MemFree:          9780 kB
> MemShared:           0 kB
> Buffers:             0 kB
> Cached:           2472 kB
> SwapCached:          0 kB
> Active:           1088 kB
> Inactive:         1792 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:        14180 kB
> LowFree:          9780 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
>
> Question: Why the total (and "available" value at startup) indicates
> ~14M...why doesn't it say 16M (and what is the ~2.5M "cached" value). Thanks
> again in advance.

The memory line from the boot sequence tells you why total is not 16MB.
The kernel is already using it... :)

You can find the answer to your cached question if you look at the code
from fs/proc/proc_misc.c

Jeff Angielski
The PTR Group


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
