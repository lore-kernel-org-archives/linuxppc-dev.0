Message-ID: <39AD4E8F.76FB97E0@relog.ch>
Date: Wed, 30 Aug 2000 20:12:31 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm statement in include/asm not ansi conform
References: <39AD48FD.9D649CCF@uni-giessen.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marc Dietrich wrote:

> I just compiled XFree from dri.sourceforge.net, which uses the "-ansi"
> option for compiling.

Is that defined in xc/config/cf/host.def? It's always a good idea to tweak
that file before an X build.


> Problem is, that this fails on some "asm" instructions in e.g.
> include/asm-ppc/processor.h. I'm not very firm with C but is it posible to
> replace this with __asm__ ? I compiled X without -ansi and it seems to work.

So the DRI is working for you? Cool, we are two now then ;)


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
