Message-Id: <200006041356.PAA00976@piglet.grunz.lu>
Date: Sun, 4 Jun 2000 15:55:59 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [patch] VRAM detection in controlfb
To: ajoshi@shell.unixbox.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10006031728230.9136-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   3 Jun, this message from Ani Joshi echoed through cyberspace:
>> For those with multiple display adapters, do you think an option
>> controlfb:off might make sense?

Silly me; that's already taken care of in fbmem.c.

>> As there is no way to control which card
>> gets assigned which framebuffer device, that might help in certain
>> situations...
>
> I believe you can set which driver gets init'ed first by using the args:
>
> video=foo:blah video=bar:blah

Right, that's handles in fbmem.c. Unfortunately, I've never seen it
documented anywhere... So, I've started to write up a doc about
framebuffer kernel command line options. I've come across a few
oddities; among others the format of options:

1. What do the vc: and map: options do?
2. Why can you specify more options after 'scrollback:', separated with
   a ',', but not after the 'map:' option (no other options possible),
   whereas you can have more options following 'vc:', but without a
   separator?

Thanks

Michel

BTW, anybody have the fbutils compiled for 2k and recent kernels? I
can't seem to get it to compile....

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
