Message-ID: <406D92CF.8040302@gcctech.com>
Date: Fri, 02 Apr 2004 11:20:31 -0500
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: General question about caching
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a tight footprint, and no swapping (in fact no disks).  I notice
that /proc/meminfo reports:

        total:    used:    free:  shared: buffers:  cached:
Mem:  31686656 30740480   946176        0  4591616 12210176
Swap:        0        0        0
MemTotal:        30944 kB
MemFree:           924 kB
MemShared:           0 kB
Buffers:          4484 kB
Cached:          11924 kB
SwapCached:          0 kB
Active:          22196 kB
Inactive:         5416 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        30944 kB
LowFree:           924 kB
SwapTotal:           0 kB
SwapFree:            0 kB

I only have rom and ram-based file systems, so I believe that disk
caching could and maybe should be reduced to use less space.  Can I
control this?  How?  I notice that most of the cache_init routines
running in init/main.c use mempages as the arg.  What would be the
ramifications of simply reporting less memory to those functions?
 Downside?  Danger?

Your input is appreciated!

cj


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
