Message-Id: <200008222115.XAA00745@piglet.grunz.lu>
Date: Tue, 22 Aug 2000 23:15:29 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Control fb problem on 8500
To: daenzerm@student.ethz.ch
cc: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
In-Reply-To: <39A25283.1A7B0E3C@relog.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  22 Aug, this message from Michel Dänzer echoed through cyberspace:
> Geert Uytterhoeven wrote:
>> I never read any XFree86 4.0 code.
>>
>> I know ShadowFB is faster for machines without hardware acceleration. But is
>> it also faster with hardware acceleration?
>
> ShadowFB and hardware acceleration are mutually exclusive (except for hardware
> cursor and other things I am forgetting). With ShadowFB, the framebuffer is in
> main RAM and only the updated parts are copied to video RAM.
>
> However, as the fbdev driver has no acceleration, this doesn't matter, and
> ShadowFB is a win in most cases. And for the other drivers which use fbdevhw,
> the assumption 'displayWidth == virtualX' holds, so they work correctly
> without ShadowFB.

Hm, speaking of hardware cursor. Since this all started on exactly that
issue.... supposing someone actually finds out how control's hardware
cursor works, and supposing someone would actually take the time to
implement this, wouldn't we need to provide a XFree driver as well? I
guess plain fbdevhw doesn't support hw cursor...

In that event, would it be possible to address the above-mentioned flaw
in XFree in that particular driver, or is the problem more geneic (i.e.
littered throughout the source tree)?

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
