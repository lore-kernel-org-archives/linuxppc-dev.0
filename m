Message-Id: <199908290558.HAA00264@piglet.cpu.lu>
Date: Sun, 29 Aug 1999 07:58:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: IBM 850 LinuxPPC installation?
To: hollis+@andrew.cmu.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96L.990828184233.3389E-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  28 Aug, this message from Hollis R Blanchard echoed through cyberspace:
>> Also, you might want to try patching your kernel with Andre Hedrick's
>> multi-platform uniform IDE driver (look at
>> ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/). You _might_
>> need additional patches to get it to boot; if so, get back to me, and
>> I'll produce a diff against my working kernel.
> 
> I don't know if you read my most recent info, but after disconnecting the
> cdrom drive (hdc), I'm getting lots of 
> hda: lost interrupt
> 
> My dmesg otherwise looks the same - just drop every mention of hdc. If you
> think that uniform IDE driver would help with my current problem let me know
> and I'll give it a shot.

Definitely give it a try. Do you know what hardwre is your IDE
interface? Is it integrated into some chipset? If so, which one?

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
