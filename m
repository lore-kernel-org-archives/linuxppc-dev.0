Date: Thu, 31 Aug 2000 18:09:19 +0200 (CET)
From: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
To: daenzerm@student.ethz.ch
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm statement in include/asm not ansi conform
In-Reply-To: <39AD4E8F.76FB97E0@relog.ch>
Message-Id: <Pine.A41.4.21.0008311751210.17008-100000@c2.hrz.uni-giessen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Michel,

after some testing dri works now. On startup X says "dri enabled" and
glinfo shows many supported GL functions. But at least when running
"gears" for example, I get no accelaration at all. Still 60 frames per
second - same as with software rendering. I also have a P-III/500 box with
Rage128 (AGP) witch produces 400 frames! Glxinfo says something like "RGB
error" and breaks.

Maybe it's better at your site?

Marc

On Wed, 30 Aug 2000, Michel Dänzer wrote:

> Marc Dietrich wrote:
>
> > I just compiled XFree from dri.sourceforge.net, which uses the "-ansi"
> > option for compiling.
>
> Is that defined in xc/config/cf/host.def? It's always a good idea to tweak
> that file before an X build.
>
>
> > Problem is, that this fails on some "asm" instructions in e.g.
> > include/asm-ppc/processor.h. I'm not very firm with C but is it posible to
> > replace this with __asm__ ? I compiled X without -ansi and it seems to work.
>
> So the DRI is working for you? Cool, we are two now then ;)
>
>

Marc Dietrich                marc.dietrich@physik.uni-giessen.de


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
