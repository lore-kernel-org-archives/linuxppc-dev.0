Message-ID: <3A785A27.C0366BC3@iiic.ethz.ch>
Date: Wed, 31 Jan 2001 19:32:07 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Andreas Hundt <andi@convergence.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com> <19341226052133.13170@mailhost.mipsys.com> <3A782739.63582B86@convergence.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Hundt wrote:

> - driver now supports RGB565 16-bit mode

Looks like you killed RGB555 instead? I have another patch which makes both
available, but I never got the colors right in 565. I'll try to merge my patch
into yours and re-post it here and to Brad Douglas.


> - pannig works now, allows correct dublebuffering, without jittering screen.
>
> - FB_ACTIVATE_NOW and FB_ACTIVATE_VBL are now supported, CRTC_OFFSET_CNTL
>   register is set correctly. aty128fb only accepted FB_ACTIVATE_NOW before
>   but acted always like FB_ACTIVATE_VBL.
>   This fix eliminates flickering in ClanLib (and other fbdev applications)
>   when using doublebuffering.
>
> - no more messed up colors in modes > 8 bpp. driver no longer uses hardware
>   palette in modes > 8bpp, sets fbcon palette correctly instead.

Sounds great!


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
