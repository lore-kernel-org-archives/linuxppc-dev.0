Message-ID: <3A7853D6.5AE4CC71@iiic.ethz.ch>
Date: Wed, 31 Jan 2001 19:05:10 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Stefan Jeglinski <jeglin@4pi.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: continuing XF402 (atimisc) problems
References: <p04330102b69d64c82c08@[24.163.36.97]> <19341226073701.30276@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >I've been over this on the -user list and the YDL list, and cc-ed Ani
> >a few times with it (no response). No one seems to have a clue as to
> >the cause of the problem, which is described concisely at:
> >
> ><http://lists.linuxppc.org/listarcs/linuxppc-user/200101/msg00672.html>
> >
> >(more detail available if necessary)
> >
> >This is on a 6500 (on-board RageII) with a RagePro PCI card. I have
> >tried rolling my own XF402 build, with Ani's driver updates, and get
> >the exact same XFree log result. I've also tried several of kfukui's
> >402 rpms, including use of his "old drivers," again with exactly the
> >same result.
>
> Check that you have the correct fbdevhw module and that it's loaded in
> your XF86Config file.

The atimisc driver should load fbdevhw if it needs it. Look at the r128 or
glint, ... drivers on how to do it.

Anyway, this whole fbdevhw mess will hopefully soon go away for a clean
solution.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
