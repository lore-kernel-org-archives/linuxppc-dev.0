Message-ID: <3CBF2D66.55B0D580@esteem.com>
Date: Thu, 18 Apr 2002 13:32:38 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: boehringer@snom.de
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
References: <NFBBLKLHNAGPKBMPDMALIEICKAAA.jacky@premierme.com.tw> <3CBEDFB2.7E0548C1@snom.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sven Boehringer wrote:
> >
> > We have done it. There shouldn't be much to do provided you have the
> > PCMCIA interface connected correctly.
> >
> > There was a mistake in the Motorola manual on the MPC850. It involved
> > two lines having to be swapped.
>
> That sounds interesting, can you please tell me which lines? Cause I'm
> right on the way to
> do such a interface...
>
> And a little bit OT, but how do you implement the BCSR's? I looked for
> the (ABEL)-Source which is provided with the Manual
> (MPC8xxFADSMENGUM.pdf) but i found no good tool to extract the needed
> pins...
>
> Any help would be very pleasant,
>
> Regards
>         Sven Boehringer

Hi Sven,

	We were told that the RESET_B and the POE_B needed to be
swapped. Somewhere motorola has an app note on it.

Looking at the MPC850UM.PDF that I downloaded today they have corrected
the error. Our printed manual has the mistake.

RESET_B is connected to OP3
POE_B is connected to OP2


I can't find the register you are reffering to (BCSR). Could you spell
it
out?


Hope this helps.

--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
