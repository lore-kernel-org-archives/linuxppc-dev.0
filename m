Subject: Re: Control-C in bash ???
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: markc@mail.com
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <200301131409.00113.markc@mail.com>
References: <200301131409.00113.markc@mail.com>
Content-Type: text/plain
Date: 14 Jan 2003 13:31:45 +0000
Message-Id: <1042551106.8605.109.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mark,

I had exactly the same problem with ash (busybox version), but I found
it went away when I replaced

ttyS0::respawn:-/bin/sh

in /etc/inittab with

ttyS0::respawn:/sbin/login

I have no idea why....

Alex



On Mon, 2003-01-13 at 19:09, Mark Chambers wrote:
>
> On a PC, I can, for instance, enter "ping 192.168.1.4", then hit Control-C
> and stop the ping.  For the life of me, I can't figure out how to do the
> same on my MPC860 system!!!
>
> I have an MPC860 running 2.4.19, with a mostly unmodified eldk distribution
> from Wolfgang Denx.  I did modify the init script to use /dev/console instead
> of /ttyx (standard driver using SMC1).  I'd not only like a solution, I want
> to undertand how cancelling a shell command is supposed to work  - I've poked
> around and I can't figure out what's supposed to happen - Does the shell
> generate a SIGINT, or the uart driver, or what?  Any enlightenment will be
> greatly appreciated...
>
> Mark Chambers
> markc@mail.com
>
> -------------------------------------------------------
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
