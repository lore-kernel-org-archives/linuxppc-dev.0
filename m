Message-Id: <200006250739.JAA00730@piglet.grunz.lu>
Date: Sun, 25 Jun 2000 09:39:30 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Accessing IO space via resources
To: costabel@wanadoo.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <395527BA.3E61D7BC@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  24 Jun, this message from Martin Costabel echoed through cyberspace:
>> After investigating this, it turns out that early in the boot process,
>> before the mm system is up, ioremap returns virt == phys for
>> addresses >= ioremap_base. ioremap_base got changed from 0xf8000000 to
>> 0xf0000000 in recent kernels. Anybody kow why this got changed?
>
> Browsing bk diffs (BTW, it's rather the other way round),

Oooppss.. of course.

> this looks
> very much like a typo. Paulus, on 06/09/2000, cleaning up too
> thoroughly?

Might be...

But on the other hand, what's the reason for having the ioremap_base
limit other than for the sake of mapping 1:1 above it?

If the reason is to map 1:1, no luck... there's hardly anything besides
ROM above 0xf8000000 on PowerMacs. In that case, and supposing it was
moved to make more room below it, it can be moved to 0xffffffff anyway..

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
