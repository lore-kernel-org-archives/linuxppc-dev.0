Date: Fri, 7 Mar 2003 17:18:30 +0000
From: Magnus Damm <damm@opensource.se>
To: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA
Message-Id: <20030307171830.1dca14f1.damm@opensource.se>
In-Reply-To: <se68594f.071@mail.frequentis.com>
References: <se68594f.071@mail.frequentis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> We are using MPC860T with one possible PCMCIA port and Montavista kernel 2.4.2.
> So it is possible to use every PCMCIA card, which is supported by Linux?

Not all cards worked "right out of the box" when I wrote the socket driver.
And I don't think that all of them will work today either.
There are many things that might cause problems - endian unawareness, timing stuff etc.

So you will not be able to install a set of RPMs on your hardware and then just
insert any PCMCIA card and hear bleep-bleep and everything works. No.
But with some hacking and some knowledge of Linux and PCMCIA you will probably
find out a collection of PCMCIA cards that will work ok.

I don't know how many PCMCIA cards that Linux/pcmcia-cs supports, but I guess
that everyone uses CARDBUS today instead of PCMCIA. 32 bits are much more fun.

I think that I read that someone was planning on writing a list, but I don't
remeber seeing any actual output. Or maybe I missed that.

There are (were anyhow) many things that differs between a common PC and
the Linux implementation on a embedded powerpc box. The IDE stuff, serial
ports and other things are treated different. And it all depends on the
variant and version of your kernel. What fun.
And the status of your Montavista kernel - I have no idea.

Have you modified the socket driver to fit your hardware?
You will not be able to use any PCMCIA card without correct configuration.

Hope this leads you in the right direction.

/ magnus

On Fri, 07 Mar 2003 08:32:47 +0100
"Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com> wrote:

>
> Hi again!
>
> Maybe I frogot some information:
>
> We need for a project a second 100MBit interface, so our soloution will be to use a PCMCIA card. Does there exists an actual compatibility list which cards works, which not? I only found a list from 2000 or 2001.
>
> Please help :-)
>
>
> We are using MPC860T with one possible PCMCIA port and Montavista kernel 2.4.2.
> So it is possible to use every PCMCIA card, which is supported by Linux?
>
> Again, please help...
>
> best regards
> Gerhard
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
