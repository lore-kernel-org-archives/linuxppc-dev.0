To: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Mar 2003 08:32:47 +0100."
             <se68594f.071@mail.frequentis.com>
Date: Fri, 07 Mar 2003 20:53:28 +0100
Message-Id: <20030307195333.43AC2C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
