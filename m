Date: Sun, 10 Aug 2003 21:09:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.0-test3-bk1 -- include/asm/smp.h:61: error: `NR_CPUS' undeclared (first use in this function)
Message-ID: <20030810190954.GA13537@lst.de>
References: <200308101142.16491.miles.lane@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308101142.16491.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 10, 2003 at 11:42:16AM -0700, Miles Lane wrote:
>
>   CC      kernel/timer.o
> In file included from include/linux/smp.h:17,
>                  from include/linux/kernel_stat.h:6,
>                  from kernel/timer.c:22:
> include/asm/smp.h: In function `any_online_cpu':
> include/asm/smp.h:61: error: `NR_CPUS' undeclared (first use in this function)
> include/asm/smp.h:61: error: (Each undeclared identifier is reported only once
> include/asm/smp.h:61: error: for each function it appears in.)
> make[1]: *** [kernel/timer.o] Error 1

I had that for a while now.  Including <linux/threads.h> in <asm/smp.h>
fixes it.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
