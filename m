Date: Thu, 21 Nov 2002 07:38:23 -0700
From: Matt Porter <porter@cox.net>
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cannot compile 2.4.19 with kgdb/xmon
Message-ID: <20021121073823.A8252@home.com>
References: <3DDC81F0.50200@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DDC81F0.50200@tataelxsi.co.in>; from omanakuttan@tataelxsi.co.in on Thu, Nov 21, 2002 at 12:19:20PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 21, 2002 at 12:19:20PM +0530, Omanakuttan wrote:
> The configuration compiles fine when I exclude kernel hacking options.
> Once kgdb or xmon options (any of them)  of the kernel hacking options
> is included, kernel compilation fails with the following

<snip>

> arch/ppc/kernel/kernel.o(.text+0x8f58): undefined reference to
> `getDebugChar'

Most classic PPC based embedded boards don't have the glue code
enabled to use kgdb.  I suggest you link in the standard gen550_*.c
library of polled access functions and enable access by following
the example in ebony.c.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
