Message-Id: <199906140516.HAA06439@denx.muc.de>
To: linuxppc-dev@lists.linuxppc.org
cc: "Michael R. Zucca" <mrz5149@acm.org>,
        Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        =?ISO-8859-1?Q?Kolbj=F8rn_Barmen?= <kolla@nvg.ntnu.no>
From: Wolfgang Denk <wd@denx.muc.de>
Subject: Re: MPC8xx: Bad emulation 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Jun 1999 05:31:37 +0200."
             <Pine.LNX.4.10.9906140527340.30963-100000@daneel.nvg.ntnu.no>
Date: Mon, 14 Jun 1999 07:16:21 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 13 Jun 1999, Michael R. Zucca wrote:
>
> I'm surprised. I thought we were already doing this.  This sort of thing

So thought I; but the existing solution is far from being complete.

> has been done forever on the 68k to emulate the 68881/2 FPU. It's slow but
> if you don't plan on doing much floating point, it's perfectly acceptable.

Agreed.


On Mon, 14 Jun 1999, Kolbjørn Barmen wrote:
> 
> It was working sometimes on some old 1.2.x kernels and perhaps older, it hasnt
> been working since afaik, and hasnt been much of an issue until recently on
> old macs, as most of atari and amiga owners has gotten ourselves 68881/2 chips
> in the meantime.

It is perfectly understandable that there is  no  much  interest  for
this on the workstation class of Linux boxen. But especially with the
PPC port and Embedded Controllers like the Motorola MPC8xx or the IBM
401x2  I  se  a  good chance for Linux entering the world of embedded
(and realtime) systems. This opens a whole new set of requirements.

Wolfgang Denk

-- 
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is impractical for  the  standard  to  attempt  to  constrain  the
behavior  of code that does not obey the constraints of the standard.
                                                          - Doug Gwyn

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
