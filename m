Message-ID: <3AC8C866.AE9CDA83@mvista.com>
Date: Mon, 02 Apr 2001 14:43:50 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: machael <dony.he@huawei.com.cn>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does linux-2.4.0-test1 support 8260?
References: <000b01c0a2e5$c499d400$8021690a@huawei.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


machael wrote:

>       Does linux-2.4.0-test1 support 8260?

I haven't tried it recently, but it used to work.  I just used
the linuxppc_2_5 baseline to port a couple of new 8260s I received.
It worked fine.  I don't recall anything (except probably the I2C
stuff) that is in this baseline and not in 2.4.  You may want to
get a newer kernel, like 2.4.2, and from someplace like FSM Labs.
There are some uart driver hacks for SCC console that don't seem
to be working, but I can't think of anything else.

> Note that there is an error  when showing "Freeing initrd memory: 4194300k
> freed" .

That's just a stupid 'printk' problem printing a bogus variable (that
I think several people, including me, have checked in a fix).
There isn't any bug associated with that.

I know it's very hard, but have you verified your memory timing
parameters with some simple test programs?  Once Linux starts
running with MMU and caches enabled, it pushes the limits of the
hardware and nasty things like this start to appear.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
