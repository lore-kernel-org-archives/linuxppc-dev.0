Message-ID: <20000927220429.29765.qmail@ww181.netaddress.usa.net>
Date: 27 Sep 00 17:04:29 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: "Jon Erick Ween" <jween@som.llu.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree86-4.0.1, Lombard, Been There - Done That
CC: <schmitz@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For the 80th and last time. Get the XF86Config.pismo from howarths directory.
Switch the references from rage128 to ati. Copy this file to
/etc/X11/XF86Config . The timings will work. I am not using the latest version
of the ati driver (X) but mine works. When booting a recent kernel with
yaboot, you should not have to specify video= on a lombard. It will by default
use 1024x768 60hz and atyfb. If you are not getting a cursor, I would bet You
either gummed something up in your .config or you are specifying uneccessary
video options. Also make sure you aren't telling yaboot to use "novideo". If
you are not getting a cursor after verifying that, use one of Ben's
precompiled kernels. I am using one of his older precompiled kernels (with
direct boot ati accel fixed), the ati driver from a month ago, xf401 from
franz's rpms, and a slightly edited XF86Config file that used the pismo file
as a template.  The only bug I have is that i get a few blue garbage pixels
when areas with blue in them redraw.

-Jeramy

> OK, I've switched from BootX to Yboot using a stable 2.2.17 kernel and the
> most recent XF86-4.0.1 and ati driver sources I can find. I seem to get
> different PCI assignments to the ATI chip on boot-up (looking at dmesg
> compared with using BootX) but the X-server still doesn't detect the chip
> with "startx" or "XFree86" and exits with a "device not found" and "no
> screens" error. Any further suggestions?
>
> Thanks
>
> Jon
>
> --
> Jon Erik Ween, MD
>
> Cognitive and Cerebrovascular Neurology
>
> Assistant Professor
> Loma Linda University School of Medicine
>
> Director, Stroke Program
> Loma Linda University Medical Center
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
