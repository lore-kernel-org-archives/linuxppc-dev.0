Message-ID: <37615D97.EF08C746@americasm01.nt.com>
Date: Fri, 11 Jun 1999 15:03:51 -0400
From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org, mlan@cpu.lu
Subject: Re: Q: control is a C&T 65550?
References: <19990611180811.016528@mail.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> On Fri, Jun 11, 1999, Michel Lanners <mlan@cpu.lu> wrote:
> 
[snip] 
> >What a shame! After all, the control hardware can be seen as a legacy
> >device, being surpassed by any and all current video chips... or might
> >Apple be hiding some really cool and powerful feature deep inside
> >control? I doubt it....
> 
> I don't think so. There is however some kind of "graphic accelerator" for
> control in MacOS, It's quite small, I don't know if it only provides
> better blit routines optimised for non-cachable space, or eventually
> hacks the MMU to make the fb space cahable (for bursts), I don't think
> there's anything like a blitter or a DMA engine in control.

Do you have any guess what the graphic accelerator for Platinum does? 
At the moment, platinum is also used just as a frame buffer. 

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
