Message-ID: <3B6C64A7.9040005@hadess.net>
Date: Sat, 04 Aug 2001 22:09:59 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: Ethan Blanton <eblanton@cs.ohiou.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: DRI on an iBook2
References: <20010804225709.A861@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On PPC, we can't use AGP GART because of the lack of documentation for
the chipsets Apple uses on its motherboards. But we have PCI GART.

Grab the DRM modules sources here: http://xfree86.org/~alanh/

Compile, insmod r128.o, modify your XF86Config to include the dri,
glcore and glx modules, and use 16bpp by default (the iBook2 doesn't
have enough video ram to do OpenGL at 1024x768@24bpp).

Start X-Windows and you should be set ;)

glxinfo's first lines will tell you if you got DRI to work.

Cheers

PS: If you want to see my XF86Config-4, tell me, I'll post it on my site.

Ethan Blanton wrote:

>Hi,
>I see on the DRI project (http://dri.sourceforge.net/) page that the
>ATI Rage128 Mobility chipset is supported by XFree86 DRI.  However,
>I'm not having a whole lot of luck getting anything working on my
>iBook2.  I notice that I *can* turn on the kernel option for the DRM
>and select support for the ATI Rage128.  My question to this list
>before I spend too much time beating my head against this is whether
>or not DRM and/or DRI for the ATI chipsets are supported on LinuxPPC.
>
>Thanks...
>Ethan
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
