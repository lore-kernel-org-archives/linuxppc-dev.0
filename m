Message-ID: <39B1D6CF.351969B4@primenet.com>
Date: Sun, 03 Sep 2000 04:42:55 +0000
From: Bob Doyle <doyle@primenet.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC2AB9.D47ADE73@mvista.com> <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC0BF9.38DB6A9A@mvista.com> <20000830215856.B5340@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have code that initializes (some of) the sandpoint hardware -
enough to get the sandpoint to copy and gunzip stuff (code etc)
from the floppy disk to memory.  I program it into the PPMC
flash memory and use it to load a proprietary OS.  The floppy
code polls the floppy controller so I don't need to have
interrupts and DMA in the bootloader.

I also have code that knows how to initialize a couple of
different VGA cards that I use.

If someone was interested in making a more useful bootloader
for linux/sandpoint I'd look into cleaning it up (removing
the proprietary stuff) and releasing the code.

Bob.

Alex Shnitman wrote:
>
> On Tue, Aug 29, 2000 at 12:16:09PM -0700, you wrote the following:
>
> > > I downloaded the kernel and tried it. It starts booting, but it hangs
> > > right after initializing the the OpenPIC. :-( I'll download the source
> > > code tonight and try to look at it, although I don't have much hopes
> > > gotta learn though.
> > >
> > > Is there any book that you recommend to get me started? Any other
> > > docs/tips?
> >
> > Oops, I should have included the sandpoint switch settings.  For
> > this version of the kernel, the sandpoint switches must be set as
> > follows:
> >
> > S4,S3: up, down
> > S5: down
> > S6: down (yours is probably up which is why it hung in openpic)
> >
> > Try this and see if it helps.
>
> It did! The kernel boots fine now all the way through.
>
> Thanks a lot!
>
> Another question: what would be the best way to go about booting Linux
> from the flash? Would flashing the kernel in instead of the dink32
> monitor do the trick, or does dink32 do some important initializations
> that are needed for the kernel to boot?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
