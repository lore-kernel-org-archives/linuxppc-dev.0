Message-ID: <39B110B9.6266196F@student.ethz.ch>
Date: Sat, 02 Sep 2000 16:37:45 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: asm statement in include/asm not ansi conform
References: <39AFCE61.7D68ED0C@ivey.uwo.ca> <20000901161432.8125@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> There is at least one r128 based PCI card for Mac that uses a different
> clock rate. I think we should (for the future at least) add code to
> aty128fb to recongnize it and return proper values from a private ioctl.
> That wouldn't help users not using aty128fb, but on Macs, I beleive those
> will be rare.

Only if 16 bit works properly in aty128fb (I have it working in console, still
wrong colors with X, patch sent to Brad Douglas), otherwise people who want to
use DRI are forced not to use it with X.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
