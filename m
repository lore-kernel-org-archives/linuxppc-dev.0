Message-Id: <200106262038.WAA00789@piglet.grunz.lu>
Date: Tue, 26 Jun 2001 22:38:03 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Crash on BenH's latest rsync (2.4.6-pre3)
To: trini@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010626121003.D31231@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  26 Jun, this message from Tom Rini echoed through cyberspace:
> On Mon, Jun 25, 2001 at 10:29:13PM +0200, Michel Lanners wrote:
>
>> Anyone seen this? Anyone want me to look further into debugging this?
>
> Not this one in particular, but I'm tracking 2 different oopses w/
> the tree on a new iBook right now.  2.4.5-pre3 is rock solid too :)

;-)

> How did you get that oops?  There seems to be a problem w/ inserting
> power to a sleeping 'book.  Or at least w/ this one.

I was only booting the book; doing nothing particular. It wasn't stable
enough be to be up long enough to go to sleep....

Ben suggested trying without the USB OHCI driver, but no dice; same
crash.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
