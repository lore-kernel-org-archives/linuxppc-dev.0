Message-ID: <39AF896D.E0E1EE28@student.ethz.ch>
Date: Fri, 01 Sep 2000 12:48:13 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: asm statement in include/asm not ansi conform
References: <Pine.A41.4.21.0009011115240.32258-100000@c2.hrz.uni-giessen.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marc Dietrich wrote:
>
> On Thu, 31 Aug 2000, Benjamin Herrenschmidt wrote:
>
> > There's no support for the AGP bus mastering on PowerMac yet. I've been
> > running into trouble implementing that due to differences between what
> > the linux /dev/agpgart driver expect an AGP chipset to do, and what
> > Apple's UniNorth can actually do.
> >
> > I plan (this week-end) to look more closely at the r128 DRI code to see
> > how it uses the AGP and possibly implement a pmac-specific driver (at
> > least for now. Once I have working code, I can try to get the existing /
> > dev/agpgart driver redesigned).
>
> I fear this won't help much in my case (with b&w G3). Anyway there's still
> a lot to do. DRI is very unstable and it seems that some functions are
> missing.

It has been very stable for me so far, I suspect we have different definitions
for "stable". About the missing stuff (and any problems), please post to
dri-devel@lists.sourceforge.net or submit bugs to the DRI project at
SourceForge. I'm not currently aware of any major bug, so I don't really know
what to do :)


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
