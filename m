Date: Wed, 10 Mar 1999 22:29:05 -0600 (CST)
From: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
Reply-To: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Promise Ultra33 in PowerMac?
In-Reply-To: <199903100706.IAA00340@piglet.cpu.lu>
Message-ID: <Pine.LNX.3.96.990310222255.22565A-100000@Astro.Dyer.Vanderbilt.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 10 Mar 1999, Michel Lanners wrote:

> Hi all,
> 
> I'm thinking about adding a Promise Ultra33 UDMA IDE controller to my
> PowerMac. Those things, and especially the IDE disks, are so damned
> cheap...

I have inital patches to allow a PPC with PCI support to use an Ultra33;
however, the individual that started tests never finished them.

> Anyway, does anybody have any idea whether such a beast would work with
> the current ide driver stuff? I guess that PCI-wise, there should be no
> problem. It's more a question of who initialises te board, as that may
> be done by BIOS on-controller in an i386 machine, and has to be done by
> the driver on a PowerPC box.

You need the Uniform-EIDE 6.19 update to begin.

> Using i386 boards in a PowerPC box under Linux can be done, as
> demonstrated by my Compaq-OEM Matrox Millenium which works happily
> (excpet a few quirks not related to its i386-ness).
> 
> Any thoughts (apart from 'drop that idea, buy SCSI' ;-) ?

SCSI is native to Macintosh; however, I do have new chipset code that
Mac EIDE specific, the laptops I think.

> Thanks
> 
> Michel
> 
> PS Andre, you got this mail because you're listed as maintainer of the
> IDE stuff. If you know any other more apropriate oracle to answer this,
> please forward...
> 
> -------------------------------------------------------------------------
> Michel Lanners                 |  " Read Philosophy.  Study Art.
> 23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
> L-1710 Luxembourg              |
> email   mlan@cpu.lu            |
> http://www.cpu.lu/~mlan        |                     Learn Always. "
> 

Andre Hedrick
The Linux IDE guy  --  http://www.dyer.vanderbilt.edu/server/udma/

APC UPS Daemon Support Center.
			http://www.brisse.dk/site/apcupsd/
Going FSF/GNU or GPL2 source soon.




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
