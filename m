Message-Id: <200004280609.IAA00288@piglet.grunz.lu>
Date: Fri, 28 Apr 2000 08:09:20 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: VRAM detection in controlfb.c
To: drow@false.org, chepner@cs.dartmouth.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000428000745.A853@drow.res.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  28 Apr, this message from Daniel Jacobowitz echoed through cyberspace:
>
> On Thu, Apr 27, 2000 at 11:39:59PM -0400, Clint Hepner wrote:
>> I recently added another 2MB of VRAM to my PM8500
>> with control video, and was dismayed when linux wouldn't
>> recognize it.

Let me guess: you're running 2.2 kernel on an 8x00 machine....

>> My question is, is the problem only with detecting the
>> VRAM, or could there be problems addressing the VRAM as
>> well if the kernel isn't able to detect it on its own.
>
> No, there shouldn't be any problems.

The problem lies in the detection. 2.2 and 2.3 kernels have different
versions of the detection code; 2.2 will not work with 4MB on 8x00
machines, and 2.3 will not work with 4MB on 7x00 machines. So none of
the two versions is what we need :-(

> I may just support a boot parameter for this if I can't figure it
> out...

Considering that fewer and fewer people will use affected machines
(they're starting to get old...), adding a boot parameter may be the
right solution, except if by any magic we get at documentation from
Apple. I'm no magician, however ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
