Message-Id: <200003080639.HAA00275@piglet.grunz.lu>
Date: Wed, 8 Mar 2000 07:39:53 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: nvram access in 2.3.48?
To: trini@kernel.crashing.org
cc: chas@cmf.nrl.navy.mil, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000307160835.H399@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   7 Mar, this message from Tom Rini echoed through cyberspace:
[about NVRAM]
>> > there were some posts about this about a month or so ago.
>>
>> Here is the essence:
>>
>> http://lists.linuxppc.org/listarcs/linuxppc-dev/200002/msg00079.html
>>
>> And to say I do read every message on this list...
>
> Yeah, that did it (it forgot to change the CONFIG_MAC version).  I'll pass
> it along to BK.
>
> I still think it would be a good idea to try and merge the two macintosh nvram
> drivers into one tho.

Be careful; isn't the one in drivers/macintosh needed by the M68K port?

Of course, there could be one general drivers/char/nvram.c file with
all the high-level stuff, and platform-specific files only implementing
the low-level access routines. But then, there is an API to be defined
between the two.....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
