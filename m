From: Benjamin Herrenschmidt <bh40@calva.net>
To: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm statement in include/asm not ansi conform
Date: Thu, 31 Aug 2000 18:24:42 +0200
Message-Id: <20000831162442.2079@mailhost.mipsys.com>
In-Reply-To: <Pine.A41.4.21.0008311751210.17008-100000@c2.hrz.uni-giessen.de>
References: <Pine.A41.4.21.0008311751210.17008-100000@c2.hrz.uni-giessen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>after some testing dri works now. On startup X says "dri enabled" and
>glinfo shows many supported GL functions. But at least when running
>"gears" for example, I get no accelaration at all. Still 60 frames per
>second - same as with software rendering. I also have a P-III/500 box with
>Rage128 (AGP) witch produces 400 frames! Glxinfo says something like "RGB
>error" and breaks.

There's no support for the AGP bus mastering on PowerMac yet. I've been
running into trouble implementing that due to differences between what
the linux /dev/agpgart driver expect an AGP chipset to do, and what
Apple's UniNorth can actually do.

I plan (this week-end) to look more closely at the r128 DRI code to see
how it uses the AGP and possibly implement a pmac-specific driver (at
least for now. Once I have working code, I can try to get the existing /
dev/agpgart driver redesigned).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
