From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200301131920.h0DJKIb02471@hofr.at>
Subject: Re: Control-C in bash ???
In-Reply-To: <200301131409.00113.markc@mail.com> from Mark Chambers at "Jan 13,
 2003 02:09:00 pm"
To: markc@mail.com
Date: Mon, 13 Jan 2003 20:20:18 +0100 (CET)
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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

I belive that the problem is that the control-C never arives on
the console as the serial-comunication package you are using does
not deliver it (atleast minicom does not) - You can use ping -c 1
(not sure if your ping also takes -c # for the count) to ensure that
it will terminate after one ping package. That was my workaround...

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
