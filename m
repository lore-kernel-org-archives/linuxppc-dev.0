Message-Id: <199909101833.UAA17210@piglet.cpu.lu>
Date: Fri, 10 Sep 1999 20:33:11 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
To: ldl@chpc.utah.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37D929E4.205A04B8@chpc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  10 Sep, this message from Lou Langholtz echoed through cyberspace:
> After getting an extra 2MB VRAM for my PowerMac7500 and seeing that only
> 2MB were still being recognized (despite having just added the 2MB to
> total to 4MB VRAM), I dug into the controlfb.c code from 2.2.11 and
> 2.2.12 and made the following changes to get all 4MB VRAM recognized:

> <  out_8(&p->frame_buffer[0x600000], 0xa5);
> <  out_8(&p->frame_buffer[0x600001], 0x38);
> ---
>>  out_8(&p->frame_buffer[0x200000], 0xa5);
>>  out_8(&p->frame_buffer[0x200001], 0x38);

Hmm, if I remember right, there have been half a dozen patch pairs that
changed 0x600000 to 0x200000 and back over the years ;-)

I guess it's time to clear thgis up once and for all. By the way, I do
have 4 MB of VRAM, and all of it is detected with the current version
of controlfb.....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
