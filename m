Date: Wed, 20 Mar 02 16:47:55 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203210047.AA15633@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Because you enjoy our conversations? :)

Normally I do, but then we got on the subject of which patches should or
shouldn't be accepted, and I'm not going to discuss that with anyone except the
actual responsible maintainers.

> And then you'll have to go and improve the patch anyhow, if you're going
> to stick to your word. :)

Oh sure, I have a ton of improvements in mind, I just want to do them one step
at a time, i.e., not work on patch N+1 until N is in the tree.

> How is that a step backward?

The steps forward are linuxppc_2_4_devel -> linuxppc_2_4 -> Marcelo -> 2.4
tarballs on kernel.org -> Debian, Yellow Dog, etc. Sidetrack trees like
2_4_galileo are a step backward.

> All of the current galileo work is in that
> tree.

No, a better competing version of the GT-64260 work is in the 2_4_msokolov tree
on my machine.

> And a quick diff of the enet drivers in the two trees shows a
> good deal of differences, many of which aren't just cosmetic.  Isn't it
> more 'natural' to update the most up to date file?

The gt64260_eth driver in both trees is so busted that I plan to rewrite it
from scratch anyway like I already did with the rest of the GT-64260 code. (And
when I do I'll make it vastly superior to yours to convince Paulus/Marcelo to
use it over yours.)

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
