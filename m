Date: Mon, 14 Jun 1999 05:31:37 +0200 (CEST)
From: =?ISO-8859-1?Q?Kolbj=F8rn_Barmen?= <kolla@nvg.ntnu.no>
To: "Michael R. Zucca" <mrz5149@acm.org>
cc: Wolfgang Denk <wd@denx.muc.de>,
        Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC8xx: Bad emulation
In-Reply-To: <l03130303b38a1ad611d6@[216.67.3.175]>
Message-ID: <Pine.LNX.4.10.9906140527340.30963-100000@daneel.nvg.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 13 Jun 1999, Michael R. Zucca wrote:

> I'm surprised. I thought we were already doing this.  This sort of thing
> has been done forever on the 68k to emulate the 68881/2 FPU. It's slow but
> if you don't plan on doing much floating point, it's perfectly acceptable.

Since when has this been done forever on m68k?

It was working sometimes on some old 1.2.x kernels and perhaps older, it hasnt
been working since afaik, and hasnt been much of an issue until recently on
old macs, as most of atari and amiga owners has gotten ourselves 68881/2 chips
in the meantime.

It's been forever on intel though.

 Kolbjørn Barmen |    a3k/o6o/6o4e/AmigaOS/MacOS/LinuxPPC   |    // T e a m
 <kolla@nvg.org> | a12ooCT/o3o/Linux-m68k  a6oo/o3o/AmigaOS | \XX/ A M I G A
 Nettverksgruppa |    "I met the Amiga and fell in love..." | <amiga.nvg.org>
             »» Norwegian University of Technology and Science ««


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
