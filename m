Message-ID: <3E9D9A19.3010106@paulidav.org>
Date: Wed, 16 Apr 2003 10:59:53 -0700
From: Vladimir Gurevich <vag@paulidav.org>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Are big pages really been used?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Some time ago, during the discussion about module efficiency,
Dan Malek wrote the following:

> The other thing people probably don't realize is the added overhead
> of using modules.  They are placed in dynamically allocated memory,
> wasting memory space and causing addtional MMU overhead on processors
> where you really want to minimize such things.  When compiled into the
> kernel and covered with a large page mapping, you are likely to see
> lower interrupt latencies and less jitter, along with a more compact
> memory footprint.

I was looking at TLB entries on my 405GP-based system running 2.4.17-based
kernel by executing "tlb 0 63" command in BDI-2000 and could not see any
big page mappings. All page entries were 4K in size (and I could see many
that were clearly covering portions of kernel code)

My questions are:
   a) Does the abovementioned quote apply to 4xx CPUs
   b) If yes, where can I get the patches
   c) If no, how difficult might it be to do the modification
   d) Are there provisions in Linux VM to use variable-sized pages to cover
      big contiguous memory regions in order to reduce TLB reloading.

Thanks,
Vladimir


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
