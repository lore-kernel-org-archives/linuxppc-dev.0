Message-Id: <200009131951.VAA00816@piglet.grunz.lu>
Date: Wed, 13 Sep 2000 21:51:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: zeroing pages in the idle task?
To: paulus@linuxcare.com.au, cort@fsmlabs.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200009122018.WAA00786@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All, and especially Paul/Cort,

To come back to my original question...

On  12 Sep, this message from mlan echoed through cyberspace:
> I've come across a 'forgotten' feature of the PPC kernels: namely
> zeroing pages 'in advance' in the idle task.
>
> It's a feature Cort implemented some time ago, but which is disabled by
> default.
[snip]
> So, a few questions:
>
> - is there any problem with using this feature?

I didn't have any, but that's only my box then....

> - if not, would it be a good idea to enable it by default?

What do you think, Paul, Cort?

> - or, would it be better to add it to rc.sysinit, leaving it to each
>   distribution whether to enable it or not?

Maybe enabling it by default would be a good choice? It can always be
disabled...

I'll post a patch on sourceforge.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
