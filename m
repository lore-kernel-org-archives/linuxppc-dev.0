Message-ID: <38C38A78.E1C870CF@inu.se>
Date: Mon, 06 Mar 2000 11:37:44 +0100
From: Björn Lundberg <bjorn.lundberg@inu.se>
MIME-Version: 1.0
To: Brad Hards <bradh@dynamite.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: commproc.c
References: <4.2.2.20000302111129.00a638d0@mail.kerbango.com> <38C16DAC.81460D77@inu.se> <38C28434.E79774E6@dynamite.com.au>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brad Hards wrote:
>
> Björn Lundberg wrote:
> >
> > Steve Calfee wrote:
> > >
> > > Hi all,
> > >
> > > I have been working on doing a 823 USB driver. It is my first driver for
> > snip
> >
> > We've got an USB host driver in alpha stage for the 850 (done with the
> > 823 manual since 850 lacked documentation).
> The 850 Users Manual contains info (including how to program) on the USB
> host as part of CPM doco - it is chapter 32, and has been recently
> updated:
> http://www.mot.com/SPS/RISC/netcomm/aesop/mpc8XX/850/32_USB.pdf
>
> The whole users manual is linked off:
> http://www.mot.com/SPS/RISC/netcomm/docs/pubs/850UM.html
>
> Brad
>

I'm sorry I was unclear. What I ment was: Only USB function mode was
documented in 850 manuals when we started doing the host mode. This was
however freshly published for the 823.

The USB parts are the same as far as I've discovered, reading most
everything coming out from Motorola on both 850 and 823.

The bottomline is: If there is something that differs, it should be easy
to adjust.

Cheers
  Bjorn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
