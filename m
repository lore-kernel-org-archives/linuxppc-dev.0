Message-ID: <37DBDBB6.4B608A42@chpc.utah.edu>
Date: Sun, 12 Sep 1999 10:58:30 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
References: <199909101833.UAA17210@piglet.cpu.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> On  10 Sep, this message from Lou Langholtz echoed through cyberspace:
> > After getting an extra 2MB VRAM for my PowerMac7500 and seeing that only
> > 2MB were still being recognized (despite having just added the 2MB to
> > total to 4MB VRAM), I dug into the controlfb.c code from 2.2.11 and
> > 2.2.12 and made the following changes to get all 4MB VRAM recognized:
>
> > <  out_8(&p->frame_buffer[0x600000], 0xa5);
> > <  out_8(&p->frame_buffer[0x600001], 0x38);
> > ---
> >>  out_8(&p->frame_buffer[0x200000], 0xa5);
> >>  out_8(&p->frame_buffer[0x200001], 0x38);
>
> Hmm, if I remember right, there have been half a dozen patch pairs that
> changed 0x600000 to 0x200000 and back over the years ;-)
>
> I guess it's time to clear thgis up once and for all. By the way, I do
> have 4 MB of VRAM, and all of it is detected with the current version
> of controlfb.....

If I had a spare PowerMac 7500 I'd love to test every combo and see what gets
detected where. Unfortunately I don't, but hope someone else can do this
instead and get conclusive info that we need. It concerns me too that people
with 8500's (that seem to have the same graphics card) seem to observe
different behavior in detection.

What version of controlfb are you using? Current from the 2.2 kernel tree,
2.3 kernel tree, or 2.2 or 2.3 from vger, or even somewhere else. 2.2.12
wouldn't detect all 4MB VRAM in my 7500 box. I'm sorry but I haven't kept up
very well with all the different distributions of source. Let me know which
release then you use and I'll eagerely check it out ;-)

> Michel . . .


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
