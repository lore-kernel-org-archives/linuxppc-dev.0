Message-Id: <199907010605.IAA00270@piglet.cpu.lu>
Date: Thu, 1 Jul 1999 08:05:33 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Linux/PPC hardware question.
To: mikep@ugcs.caltech.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199907010132.SAA11287@xeno.ugcs.caltech.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  30 Jun, this message from Michael Pruett echoed through cyberspace:
> What SCSI cards are supported under Linux/PPC?  I wanted to use a UW
> SCSI card on my Power Mac 8500, but I can't find any information on
> which cards will work under Linux.  And I don't want to buy one unless
> I know it's supported.

Basically, any card supported by Linux/i386 should work, however:

- PCI address assignment might be a problem; I'm not sure OF assigns
adress regions for cards without OF code onboard. It might do that OK,
however.

- Any card lacking OF support on-board (i.e. all cards not sold
specifically for the Mac) will not permit booting off drives on these
boards, as OF will not have a driver for those.

- Any board that works under MacOS (including boot support) and that
has a Linux-supported chipset should be usable for booting.

Some boards I know people have working:

- Symbios 875? -based: Geert.Uytterhoeven@cs.kuleuven.ac.be
- a large number of Adaptec boards, through the AIC7xxx driver
- the boards Apple sold bundled with Macs (I think most, if not all,
are Sym875-based)

If anybody has more details or corrections, don't hold them back!

> I can't find the answer to this question anywhere (FAQs, Linux/PPC
> web sites, IRC, LDP, etc.)

Have you tried FAQ-O-Matic? That should have more detail. URL should be:
http://www.dartmouth.edu/cgi-bin/cgiwrap/jonh/lppc/faq.pl

You might also want to try the Linux/PPC list archives somewhere on
lists.linuxppc.org.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
