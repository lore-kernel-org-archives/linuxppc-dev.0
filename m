Date: Thu, 13 Apr 2000 09:47:32 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3
In-Reply-To: <38F5C457.C46F04B2@execpc.com>
Message-ID: <Pine.LNX.3.96.1000413094511.933C-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 Apr 2000, Joseph Garcia wrote:

> Gavin Hemphill wrote:
> > Hmmm, I've been trying to replicate the problems with my two Wallstreet
> ...
> > corruption abounds - Looks like it has something to do with an
> > interatction on DMA with the internal IDE drive and the ethernet.
>
> Could this be related to the IDE issues that have been discovered with my hard
> drive?  This would mean that there could be a bug in the way DMA is implemented
> in hardware on the wallstreet motherboard.  It has been mentioned its possible.
> (small flashback: corruption on occation when playing sound, often ro programs
> when executed (vi got hit; would run, but would error. few flipped bits
> probably), mentioned in SoundJam's readme.  'Contact Apple')
>
> Since MacOS doesn't seem to have any of these problems, there is a solution.
>
> my hard drive from dmesg:
> hda: IBM-DYLA-28100, ATA DISK drive
> hda: IBM-DYLA-28100, 7815MB w/459kB Cache, CHS=15880/16/63, (U)DMA
>
> Since my brother's lombard has a Toshiba HD, could this all be funkyness with
> IBM drives, God forbid? (as opposed to just the BMAC+ doesnt have the hw bug)
>
> Before we start being suspicious, anyone with a non-IBM drive having this
> problem?

It also happens on some desktop G3s with Western Digital drives under
MkLinux.  The only constants are the processor, the PCI bus bridge, I
think the dma controller, and the ethernet chip, and of course, the
ethernet driver.  If it's software, there's pretty much only one or two
places where it could be, given the very minimal code sharing between the
two OSes....


Later,
David

---------------------------------------------------------------------
A logician trying to explain logic to a programmer is like a cat
trying to explain to a fish what it's like to be wet.

	-- unknown, possibly Franklin Veaux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
