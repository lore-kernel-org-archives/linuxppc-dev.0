Message-ID: <39AE8559.A4F12B6D@relog.ch>
Date: Thu, 31 Aug 2000 18:18:33 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm statement in include/asm not ansi conform
References: <Pine.A41.4.21.0008311751210.17008-100000@c2.hrz.uni-giessen.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marc Dietrich wrote:

> after some testing dri works now. On startup X says "dri enabled" and
> glinfo shows many supported GL functions. But at least when running
> "gears" for example, I get no accelaration at all. Still 60 frames per
> second - same as with software rendering.

For me, gears gives even less FPS on startup with DRI than with software
rendering ;) What happens when you maximize the window?

A few possibilities to find out if you are really using direct rendering:

- set LIBGL_DEBUG=verbose
- run a program with lots of textured triangles (Quake, fire, ...)
- test, compare, test, ...


> I also have a P-III/500 box with Rage128 (AGP) witch produces 400 frames!

DRI currently only runs in PIO mode as we don't have any GART driver yet.

Anyway, this is a nice preview of what we could expect with AGP GART :)


> Glxinfo says something like "RGB error" and breaks.

Hmm, never tried it.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
