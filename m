Message-ID: <39D484DD.30E5B75D@student.ethz.ch>
Date: Fri, 29 Sep 2000 14:02:37 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
References: <Pine.LNX.4.10.10009281310500.3468-100000@cassiopeia.home>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Wed, 27 Sep 2000, Michael Schmitz wrote:
> > So here we have three fb devices in the kernel (you could check with
> > fbset that each is in fact accessible via /dev/fb[0-2]), and XFree unable
> > to cope. You specify the PCI bus ID but not the corresponding framebuffer
> > device node - I heard someone mention this was possible when I was
> > fighting the Lombard crashes, could anyone point out the syntax to use
> > there?
> >
> > If we can't specify the fb node XFree will have to probe for it (Geert
> > mentioned an easy way to do that: open the device and compare
> > pScrn->memPhysBase or fPtr->fix.smem_start to the PCI base address).
>
> Besides, the current fbdev_open_pci() can't cope with multiple cards of the
> same type, and doesn't recognize ATI Mach64.

Which should also be fixed now. Another update :)


Reminder: The binary modules are at

http://n.ethz.ch/student/daenzerm/download/X4-fbdev-test.tar.bz2

, the diff is at

http://n.ethz.ch/student/daenzerm/download/X-fbdev.diff.gz


Mr Shapiro, please test if this makes the ati driver work in your triple-head
box.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
