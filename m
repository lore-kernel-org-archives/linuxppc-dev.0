Date: Thu, 1 Jul 1999 10:07:06 -0500 (CDT)
From: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
Reply-To: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
To: Michel Lanners <mlan@cpu.lu>
cc: fray@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Promise Ultra33 in PowerMac?
In-Reply-To: <199907010554.HAA00267@piglet.cpu.lu>
Message-ID: <Pine.LNX.3.96.990701095817.18664A-100000@Astro.Dyer.Vanderbilt.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 1 Jul 1999, Michel Lanners wrote:

> Hi Andre and Mark,
> 
> On  10 Mar, this message from Andre M. Hedrick echoed through cyberspace:
> >> I'm thinking about adding a Promise Ultra33 UDMA IDE controller to my
> >> PowerMac. Those things, and especially the IDE disks, are so damned
> >> cheap...
> > 
> > I have inital patches to allow a PPC with PCI support to use an Ultra33;
> > however, the individual that started tests never finished them.
> 
> Any news on the subject? I'll probably go shopping next week, so now's
> the time to buy one of those boards, if there is a chance we can get
> them to work...
> 
> How's the status of the Ultra/66 support under Linux? Your patches seem
> to include support, but is it usable? I might not be able to get an
> Ultra/33 anymore; most shops around here don't have them anymore. Plus,
> the Ultra/66 costs exactly the same as the Ultra/33 before; so I might
> as well get the best choice right now...

Yeah Baby............just the other night I rocked both cards and I am in
the process of moving them from (EXPERIMENTAL) to SUPPORTED.

Ultra/33 is unlimited number of cards and NO BIOS chip installed!!!!
Ultra/66 is questionable for one reason only, I am 1 and 1 with this card.
One good card (rock solid) and one bad card (does not register its
presence in a PCI slot).

> Do you think you have all the necessary code for the setup of the
> board in your driver? As the on-board i386 BIOS code will not be
> executed, this might be the biggest problem. As a 'dirty' solution, one
> might try to use a bare-bones i386 emulator to run the BIOS code. That
> has been done before for a VGA board on a PowerPC. If I remember
> correctly, that emulator needed only around 100 kB of code... 

Why bother...............intel centric world bought us Bill Gates and
PnP-crap, so I am an Intel linux guy..............

> Any thoughts about Maxtor drives in general, and the Diamond Max Plus
> 5120 (91024D4) specifically? That one seems to be fast and quiet...
> optimal choice for a desktop box!

I like the Quantum KA series at 384MB/s internal transfer (I think this is
the right number, regardless, it smoked the IBM stuff by 50MB/s).

Andre Hedrick
The Linux IDE guy





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
