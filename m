Message-Id: <200004242105.XAA00390@piglet.grunz.lu>
Date: Mon, 24 Apr 2000 23:05:06 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: aty128 and offb and linux-2.3.99pre6 
To: geert@linux-m68k.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10004242008100.316-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Apr, this message from Geert Uytterhoeven echoed through cyberspace:
> On Mon, 24 Apr 2000, Chas Williams wrote:
>> In message <200004240651.IAA00313@piglet.grunz.lu>,Michel Lanners writes:
>> >It does work... but it changes the order my fbs are detected. Grrr....
>>
>> i have to agree.  this is fairly annoying since i have 2 rage pro's
>> (one on the agp and one on the pci bus) and the console should be on
>> the agp!
>
> Huh? This has nothing to do with the order of 2 RAGE PROs. Atyfb is probed for
> before offb (like it should be) since a long time, and the order is always the
> same.
>
> Try `video=map:1' to map all your virtual consoles to the second card.

Geert, is there any documentation available about these things? Like
how you go about 'advanced' framebuffer use (multiple fb's, switching
consoles between fb's, ...)? Where are the userland tools, and what do
they do (fbset and others)?

I do have some things figured out, but am still not really comfortable
with framebuffers...

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
