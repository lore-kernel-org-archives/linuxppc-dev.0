Date: Wed, 28 Jul 1999 02:17:39 -0500 (CDT)
From: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
To: Michel Lanners <mlan@cpu.lu>
cc: drow@false.org, mj@ucw.cz, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <199907280548.HAA00294@piglet.cpu.lu>
Message-ID: <Pine.LNX.3.96.990728021015.14664A-100000@Astro.Dyer.Vanderbilt.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Jul 1999, Michel Lanners wrote:

> > On a much less related note:
> > drow:~# hdparm -p /dev/hdc
> > 
> > /dev/hdc:
> >  attempting to auto-tune PIO mode
> >  HDIO_SET_PIO_MODE failed: Function not implemented
> > 
> > pdc202xx.c has no tuneproc.  Is this deliberate?

YES, there are no known or possible way to ever get the card in to a PIO
mode that is meaningful.  The BIOS defaults to a fixed value.

> > 
> > As it is I get this (off a 5400 RPM Maxtor 25.4G DiamondMax)
> > /dev/hdc:
> >   Timing buffered disk reads:  32 MB in  5.83 seconds = 5.49 MB/sec
> 
> This is not brilliant, but acceptable. What mode of operation was that
> in? UDMA? Or regular DMA or even PIO?

I am glad that it meets with your approval, if you can do better do it!
The drive is in a DMA mode 2, based on the xfer rate.

> On a related note, can you provide the patches you needed to apply
> (minus the uniform IDE stuff from Andre, which I have)? I'm planning to
> get my Ultra66 on Friday ;-)...

You will need more as I have just found a quirk in the chipset.
I know on no real way to test the adpater for the correct ribbon, yet.
It also does a fake and allows a drive to invoke the UDMA4 flag from the
drive with the wrong cable.

> Michel
> 
> -------------------------------------------------------------------------
> Michel Lanners                 |  " Read Philosophy.  Study Art.
> 23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
> L-1710 Luxembourg              |
> email   mlan@cpu.lu            |
> http://www.cpu.lu/~mlan        |                     Learn Always. "
> 

Andre Hedrick
The Linux IDE guy


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
