Date: Tue, 15 Dec 1998 11:00:50 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody?
In-Reply-To: <199812131040.LAA03780@piglet.cpu.lu>
Message-Id: <Pine.SGI.4.02A.9812151054230.11112-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 13 Dec 1998, Michel Lanners wrote:

> Anybody successfull in running matroxfb with recent vger kernels?

I've got it running on version 2.1.127 - I haven't tried on anything more
recent. What kernel version are you running.

> I've tried using it alongside controlfb as a second framebuffer, but it
> doesn't initialize. Compiled-in, it only goes through the very first
> debugging message, and then nothing more;  while as a module insmod
> aborts (slightly older matroxfb.c (1.6c)) or hangs the system (most
> recent matroxfb.c (1.8)).

Pass, have you asked Petr (Petr Vandrovec <VANDROVE@vc.cvut.cz>) about
this. I've been testing Petr's driver on a Mystique and haven't seen
anything like this.

> I've also tried to compile-in matroxfb without controlfb, but that
> failed because offb.c wasn't in (undefined ref to console_getmode et

Generally I've compiled in matroxfb, controlfb and offb into the kernel
which compile and run without any problems. I haven't tried leaving
controlfb out.

Cheers

-------------------------------------------------------------------------
Owen Waller                     |   "...sometimes I think I'm a little
PhD. Student in Control Eng.    |    more English than I am French..."
Queens University               |              - Alain Prost 
Belfast                         |
Tele: +44 (0)1232 274085        |    Fax: +44 (0)1232 667023


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
