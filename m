Message-ID: <38E2AD1C.3DF0E0@embeddededge.com>
Date: Wed, 29 Mar 2000 20:25:48 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Doug Rogers <rogers@innocon.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Another try at the run-from-Flash issue for MPC8xx/MBX/custom
References: <38E27471.83CCAC10@innocon.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Doug Rogers wrote:

> ..... It is simply a matter of size.

So, what methods are you planning to use for storing the applications,
libraries and other files you need to use and update?

> ....... I've timed the decompression of our smaller test image
> and it takes over 40 seconds on a 40MHz MBX860 board. That's too slow.

You are doing something very wrong.  I have worked on production
set top boxes that uncompress a kernel and 16 Mbyte ram disk from an
8-bit flash rom that are executing in the application in under 5 seconds.
This is a 50 Mhz 860......turn on some caches, align some data, use
faster memory.....


> I was hoping that Linux was to that point, but apparently not. Just
> having the kernel run from ROM would be helpful for now,

That saves only about 800K or so of memory.  If you are counting bytes
at that level you are in trouble already.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
