Message-Id: <200003072211.XAA00471@piglet.grunz.lu>
Date: Tue, 7 Mar 2000 23:11:14 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: nvram access in 2.3.48?
To: chas@cmf.nrl.navy.mil
cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200003072157.QAA95728@borg.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   7 Mar, this message from Chas Williams echoed through cyberspace:
>> Another weiredity I've come across in my 2.3 crusade: /dev/nvram
>> doesn't seem to work anymore.
>
> this problem arises from a different source. the nvram driver in
> drivers/macintosh needs to be converted to use the new driver initalization
> scheme (like the driver in drivers/char/nvram.c)
>
> there were some posts about this about a month or so ago.

Here is the essence:

http://lists.linuxppc.org/listarcs/linuxppc-dev/200002/msg00079.html

And to say I do read every message on this list...

Thanks

Michel

PS I've not tried this patch yet, if anyone wants to go ahead...

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
