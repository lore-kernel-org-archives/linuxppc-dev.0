Message-Id: <200106240954.LAA00837@piglet.grunz.lu>
Date: Sun, 24 Jun 2001 11:54:29 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: getting the 8600 to boot 2.4.5
To: guillaume.laures@noos.fr
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3B337C7B.1040309@noos.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  22 Jun, this message from Guillaume Laurès echoed through cyberspace:
> The trick is that in 2.4 kernel, linux tries to open the first frame
> buffer, and on machines of the 8x00 class this mean opening the sixty
> convoluer, a frame buffer that allows the use of the video output (Y/C
> and composite).

Ah, there it is! I've long wondered how Sixty6 would appear in the
device tree ;-)

> Unfortunately, linux has not a driver for it

Would be a fun project to write one ;-)

[snip]
> controlfb: Memory bank 1 present, bank 2 absent, total VRAM 2MB
>
> On a side note, this is wrong, I have the 2 banks filled, but I'll check
> this later

Yeah; Takashi Oe fixed the VRAM detection for good, but it seems his
patches have not made into any released tree yet. Maybe it's in BenH's
tree; but I didn't check recently.

If you're desperate, I can try to dig it out.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
