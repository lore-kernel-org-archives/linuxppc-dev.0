Message-Id: <199908082121.XAA03124@piglet.cpu.lu>
Date: Sun, 8 Aug 1999 23:21:59 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org, mj@ucw.cz
In-Reply-To: <Pine.LNX.4.10.9908082252170.23564-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Aug, this message from Geert Uytterhoeven echoed through cyberspace:
> On Sun, 8 Aug 1999, Michel Lanners wrote:
>> Right, according to 'Designing PCI cards and Drivers..', OF never
>> enables neither memory space, nor IO space, neither ROM. It should,
>> however, set both PCI_COMMAND_MASTER and PCI_COMMAND_INVALIDATE. I
>> didn't chek, though...
>> 
>> I'm getting a patch ready that fixes this on the PMac plkatform. Geert,
>> how about OF in your CHRP box? Does it need the enable fix as well?
> 
> Yep, my OF neither enables memory spaces on devices it doesn't have a driver
> for. It even doesn't allocate space to them.

That's even worse.... Might be one more reason for Martin to get the
dynamic resource allocation stuff for PCI devices into the kernel ;-)

Michel

PS Geert, don't stay up too long ;-)

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
