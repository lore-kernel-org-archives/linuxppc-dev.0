Message-Id: <200004240651.IAA00313@piglet.grunz.lu>
Date: Mon, 24 Apr 2000 08:51:12 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: aty128 and offb and linux-2.3.99pre6
To: geert@linux-m68k.org
cc: linuxppc-dev@lists.linuxppc.org, drow@false.org
In-Reply-To: <Pine.LNX.4.10.10004192247200.436-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  19 Apr, this message from Geert Uytterhoeven echoed through cyberspace:
> What about other frame buffer devices, like e.g. matroxfb? Does it still work
> after this patch? If yes, we can get rid of matrox_of_init() as well.

It does work... but it changes the order my fbs are detected. Grrr....
;-)

> I'd really like to get rid of all these:
>
>     s3triofb_init_of()
>     imsttfb_of_init()
>     chips_of_init()
>     matrox_of_init()
>     control_of_init()
>     valkyrie_of_init()
>     platinum_of_init()
>     clgen_of_init()
>
> These are all PCI based, so they can be found using PCI probing and marked
> busy using PCI resource management.

control is only PCI-based with some abstractions.... It can, however,
be made to look entirely like a PCI device, if you can avoid poking at
it afterwards.

I have patches for control anyway (adding it to the PCI device chain,
precisely); so I might try and implement the changes for control. Or
are you already working on this, Dan?

Cheers


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
