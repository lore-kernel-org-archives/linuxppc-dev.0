Message-Id: <199812172146.WAA00356@piglet.cpu.lu>
Date: Thu, 17 Dec 1998 22:46:30 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: matroxfb, anybody?
To: O.Waller@ee.qub.ac.uk
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.SGI.4.02A.9812151054230.11112-100000@myst.ee.qub.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  15 Dec, this message from Owen Waller echoed through cyberspace:
> On Sun, 13 Dec 1998, Michel Lanners wrote:
> 
>> Anybody successfull in running matroxfb with recent vger kernels?
> 
> I've got it running on version 2.1.127 - I haven't tried on anything more
> recent. What kernel version are you running.

2.1.130. What I hate most is it doesn't complete the PCI scan
routine.... maybe a simple bug very early in the init code?

....
>> aborts (slightly older matroxfb.c (1.6c)) or hangs the system (most
>> recent matroxfb.c (1.8)).
> 
> Pass, have you asked Petr (Petr Vandrovec <VANDROVE@vc.cvut.cz>) about
> this. I've been testing Petr's driver on a Mystique and haven't seen
> anything like this.

Not yet...

>> I've also tried to compile-in matroxfb without controlfb, but that
>> failed because offb.c wasn't in (undefined ref to console_getmode et
> 
> Generally I've compiled in matroxfb, controlfb and offb into the kernel
> which compile and run without any problems. I haven't tried leaving
> controlfb out.

This is exactly what I need... I'd like to use matrox alongside control
(have my TV on a second monitor ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
9, Montee St. Crepin           |    Ask Questions.  Make Mistakes.
L-1365 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
