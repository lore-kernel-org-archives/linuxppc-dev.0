Message-ID: <3B530F09.E93C0B8D@comdev.cc>
Date: Mon, 16 Jul 2001 08:58:01 -0700
From: Adam Wozniak <adam.wozniak@comdev.cc>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mmu problems
References: <3B4F412F.99A14D9E@comdev.cc> <3B4F5BE9.6258498B@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Adam Wozniak wrote:
>
> > I suspect there's something about the MMU that's not being configured
> > properly, but I don't really know where to start.
>
> Everyone assumes there are bugs in things they don't understand.
> While there is always the possibility of something wrong, there are
> lots of 8260s running Linux without trouble.  The same MMU code is
> used on all 6xx platforms, which includes lots of Macs that have
> been running for years.
>
> I suspect you have a memory controller or other hardware design
> problem with your board.  I have worked with many hardware engineers
> debugging memory interface problems once Linux is running.  There
> just aren't any diagnostics that exercise a system like Linux does.
> The combination of cache, burst cycles, dma, and other simultaneous
> resource uses always show design/implementation bugs you have never
> seen before.  You are describing the classic symtoms some of us have
> seen many times before.

XXXXX wrote:
>
> Sounds like either a memory controller or bridge
> initialization problem. Have you run other software on
> your board? VxWorks? a simple ROM monitor?
>
> Have you written a loop with MSR_IR and MSR_DR off which
> simply walks through all of memory? Will it hang then?
> Sometimes, a memory controller which is misbehaving will
> corrupt memory, and then you may have some problems with
> bogus instructions being executed.

I'm more likely to suspect that it is something I've done.  The piece of
hardware I'm using normally runs VxWorks, and we have several in the
field
which have been running for some time with excellent performance
records.

I do have a simple rom monitor (PPCBoot) running, and it seems to work
flawlessly.

I'll try today to get more (and better) error dumps from it.

--Adam
--
Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
