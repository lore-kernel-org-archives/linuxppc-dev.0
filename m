Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <se6c5894.038@mail.frequentis.com>
Date: Mon, 10 Mar 2003 09:18:55 +0100
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

Well this issue we discussed with our project developer...
They want to use 2 Ethernetports for a double ethernet network, for saftey issues. We know, that we never get the full 100MBit on a MPC860 however, the point is, that our hardware don't get much data, but other components (PCs) in the network needs this bandwidth. Beside this to use a SCC for Ethernet we need an hardware redesign with a lot of software adaptions....

We have only one PCMCIA Port realised in HW.

So the (your) DENX Kernel (2.4.4) has PCMCIA support implemented yet? So this is maybe a reason for us to switch over.. (Uhuhu I hope this will not too much work to adapt the configuration again.... :-)

So do you have a list which Ethernet cards work? Or is it only the Xircom card that works?

Gerhard

>>> Wolfgang Denk <wd@denx.de> 03/07/03 08:53pm >>>
In message <se68594f.071@mail.frequentis.com> you wrote:
>
> We need for a project a second 100MBit interface, so our soloution will be to use a PCMCIA card. Does there exists an actual compatibility list which cards works, which not? I only found a list from 2000 or 2001.

Why do you think you need a second 100MBit interface? The performance
of  a  MPC8xx  is  a  bit  limited,  so  don't  expect  too  much  of
throughput...

Probably a 10 Mbps interface on a SCC would be the easier solution.

> We are using MPC860T with one possible PCMCIA port and Montavista kernel 2.4.2.

I cannot speak about MV's 2.4.2 kernel, except that it's  pretty  old
and  I  doubt  it  has  full PCMCIA support. But the MPC860T supports
_two_ PCMCIA slots.

> So it is possible to use every PCMCIA card, which is supported by Linux?

You will not get any guarantees. Try it out. The (few!) network cards
we tested so far worked fine.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
C++ was an interesting and valuable experiment, but we've learned its
lessons and it's time to move on.
                            - Peter Curran in <DCqM4z.BxB@isgtec.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
