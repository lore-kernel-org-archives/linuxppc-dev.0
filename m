Message-Id: <200003072152.WAA00417@piglet.grunz.lu>
Date: Tue, 7 Mar 2000 22:52:09 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: nvram access in 2.3.48?
To: trini@kernel.crashing.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000307144823.E399@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   7 Mar, this message from Tom Rini echoed through cyberspace:
> On Tue, Mar 07, 2000 at 10:29:45PM +0100, Michel Lanners wrote:
>
>> Another weiredity I've come across in my 2.3 crusade: /dev/nvram
>> doesn't seem to work anymore.
>
> Near as I can tell (and I'm about to try this and then see if bk will pass
> it along happily) is that all the calls to nvram_init have been changed to
> pmac_nvram_init.

I've just done a quick grep through kernel code, and found lots of
nvram code in at least three files, and decided it was too late to
follow all of them ;-)

That was in a drivers/char file, under drivers/macintosh, and under
arch/ppc, if I rember right....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
