Message-ID: <3820B383.E7B64A69@schweiz.ch>
Date: Wed, 03 Nov 1999 23:13:24 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
Reply-To: a.tobler@schweiz.ch
MIME-Version: 1.0
To: Cort Dougan <cort@ppc.kernel.org>, Ani Joshi <ajoshi@shell.unixbox.com>
CC: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.25 builds
References: <381F63A2.BE4A2AD7@schweiz.ch> <19991103134212.A28448@chimaera.ppc.kernel.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Cort and others,

right now I'm in the situation that 2.3.25 seems to compile and to boot
on a 7200. Booting is going on....
Ok up. 

I included the patches from Ani except the fbmem and all others which
refused to patch with: patch -p1 -F 3 -l --verbose <patch.file
The important for me were the pgtable.h and the fbmem.c. I use the
pmac_config as default conf with ramdisk support off. And only the
platinumfb, the scsi is Mac like & with Adaptec aic78xx. Which is my
used Disk-Controller.

Now it is up with the horrible message that I have 2GB of Mem..... (only
80MB are real) ((top report))
The fbmem.patch I took from  <kernel@kvack.org> as on the list (kernel)
this day. The latest at 14:19 EST

Thanks and sorry for the moody question the day before.

Finally I return for work to 2.2.14pre3 for daily work. Wallstreet
reports will follow as soon I can get some spare time not coding for Win :-(


Cort Dougan wrote:
> 
> The next release should build for PPC.  There were some swap changes that
> had to be cleaned up.  The Linus 2.3.x trees are now nearly up-to-date with
> my tree so it shouldn't be released with ppc broken as often now.
>


Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
