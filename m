Date: Sun, 24 Mar 02 20:31:55 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203250431.AA26633@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nye Liu <nyet@zumanetworks.com> wrote:

> _devel does not work on our custom board due
> to ethernet bugs,

Not encountered any so far.

> mpsc problems, and no 750cx support.
                     ^^^^^^^^^^^^^^^^

What are talking about? Adirondack, IBM's reference board for 750CXe built for
them by SBS, has been supported (rock solid) in 2_4_devel since last summer. (I
know firsthand as I wrote all firmware and Linux code for the Adirondack and
significantly participated in the hardware design.) Also the EV-64260A I had at
SBS on which I did my first GT-64260 work had a 750CXe CPU module (SBS was
fully committed to 750CXe or 750FX for all designs by then) and ran fine.

> _devel does also
> not work 100% with ppcboot since it does not support bd_info afaik.

I'm very very glad that 2_4_devel doesn't use the bd_info crap and uses bi_recs
instead. If PPCBoot can't handle that, it's PPCBoot's problem. There is more to
the world than PPCBoot. StarMON rules!

> We do have an Abatron.

Ahh, JTAG Heisenberg debuggers. Another thing I can't stand. Real programmers
don't need no stinking JTAG debuggers. StarMON's debug capabilities are better
than any JTAG debugger and don't have the Heisenberg effects of the latter.

--
Michael Sokolov					786 E MISSION AVE APT F
Programletarian Freedom Fighter			ESCONDIDO CA 92025-2154 USA
International Free Computing Task Force		Phone: +1-760-480-4575
						msokolov@ivan.Harhan.ORG (ARPA)
Let the Source be with you
Programletarians of the world, unite!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
