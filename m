Message-ID: <3CBEDFB2.7E0548C1@snom.de>
Date: Thu, 18 Apr 2002 17:01:06 +0200
From: Sven Boehringer <boehringer@snom.de>
Reply-To: boehringer@snom.de
MIME-Version: 1.0
To: Jacky Wang <jacky@premierme.com.tw>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
References: <NFBBLKLHNAGPKBMPDMALIEICKAAA.jacky@premierme.com.tw>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jacky,

Jacky Wang wrote:
>
> Conn,
>
> hmm......
> sounds good.
>
> but, I am a newbie about programming with linux kernel and MPC850.
> Could you tell me which kernel release and how to port it smoothly?
>
> Jacky
> -----Original Message-----
> From: root@esteem.com [mailto:root@esteem.com]On Behalf Of Conn Clark
> Sent: Wednesday, April 17, 2002 12:48 AM
> To: Jacky Wang
> Cc: May Ling List
> Subject: Re: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
>
> Jacky Wang wrote:
> >
> > Hi everyone,
> >
> > I am interesting about how to port m8xx_pcmcia driver to linux kernel w/ MPC850.
> >
> > Would you mind to share your successful experience with me?
> >
> > Best Regards
> > Jacky Wang
> >
>
> We have done it. There shouldn't be much to do provided you have the
> PCMCIA interface connected correctly.
>
> There was a mistake in the Motorola manual on the MPC850. It involved
> two lines having to be swapped.

That sounds interesting, can you please tell me which lines? Cause I'm
right on the way to
do such a interface...

And a little bit OT, but how do you implement the BCSR's? I looked for
the (ABEL)-Source which is provided with the Manual
(MPC8xxFADSMENGUM.pdf) but i found no good tool to extract the needed
pins...

Any help would be very pleasant,


Regards
	Sven Boehringer

>
> Conn
>
> --
>
> *****************************************************************
>   If you live at home long enough, your parents will move out.
> *****************************************************************
>
> Conn Clark
> Engineering Stooge                              clark@esteem.com
> Electronic Systems Technology Inc.              www.esteem.com
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
