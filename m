Message-ID: <3802D9FE.1C166944@chpc.utah.edu>
Date: Tue, 12 Oct 1999 00:49:34 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
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
> . . .
>
> I guess it's time to clear thgis up once and for all. By the way, I do
> have 4 MB of VRAM, and all of it is detected with the current version
> of controlfb.....

Update:

Even with 2.2.13pre15, the stock controlfb.c still doesn't detect the
4MB VRAM in my 7500 (I just tried it). I have to hack controlfb.c to get it
to use all 4MB. This is perhaps a bug specific only to the PowerMac 7500/100
as others have reported that all VRAM was detected on their PowerMac's
without making any changes like I've had to do.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
