Message-Id: <200008190718.JAA00823@piglet.grunz.lu>
Date: Sat, 19 Aug 2000 09:18:19 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Control fb problem on 8500
To: dmj+@andrew.cmu.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000818234749.A7999@drow.them.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  18 Aug, this message from Daniel Jacobowitz echoed through cyberspace:
>> In fact, before, the line length was exactly hpixels * bytes/pixel,
>> whereas now there's an additional 0x20 bytes in each line. I have not
>> been able to boot a 2.4.0 kernel with any fix applied, but you could try
>> and build a version without those 0x20 bytes added (they are found in a
>> few spots inside controlfb.c).
>>
>> As to why these 0x20 bytes were added, anybody know an explanation? And,
>> if they do serve a purpose (I suppose so ;-), it would be better to add
>> the exact number of bytes as a #define somewhere...
>
> *sigh*
>
> I have no idea where this came from, but 0x20 means it has something to
> do with cursor support, I'd bet.  I seem to recall someone talking
> about that a few months ago... that is how hardware cursor is generally
> implemented, by a 32 pixel block at the end of the scanline.

That's what I was thinking about. However, I'm not sure that XFree
supports a display with discontiguous lines in video memory. I think I
read that somewhere in some mailing list or X doc... Can any of the
XFree specialists confirm?

My XFree 4.0 goes into an infinite loop eating CPU time when I boot a
2.4.0 kernel. Xpmac does work, but with the artifact described in my
previous mail.

Anyway, going the way of supporting the hardware cursor is good, but
we're not there yet ;-)

> Dan
> the underactive and out of touch controlfb maintainer


Michel,
the underactive and out of touch planb maintainer ;-)

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
