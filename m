Date: Fri, 1 Sep 2000 11:19:27 +0200 (CET)
From: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm statement in include/asm not ansi conform
In-Reply-To: <20000831162442.2079@mailhost.mipsys.com>
Message-Id: <Pine.A41.4.21.0009011115240.32258-100000@c2.hrz.uni-giessen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000, Benjamin Herrenschmidt wrote:

> There's no support for the AGP bus mastering on PowerMac yet. I've been
> running into trouble implementing that due to differences between what
> the linux /dev/agpgart driver expect an AGP chipset to do, and what
> Apple's UniNorth can actually do.
>
> I plan (this week-end) to look more closely at the r128 DRI code to see
> how it uses the AGP and possibly implement a pmac-specific driver (at
> least for now. Once I have working code, I can try to get the existing /
> dev/agpgart driver redesigned).

I fear this won't help much in my case (with b&w G3). Anyway there's still
a lot to do. DRI is very unstable and it seems that some functions are
missing.

Thanks for your great work

Marc

---
Marc Dietrich                marc.dietrich@physik.uni-giessen.de


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
