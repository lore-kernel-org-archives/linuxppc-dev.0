From: ramp@oddjob.uchicago.edu
Date: Thu, 27 Jan 2000 15:59:59 -0600 (CST)
To: phandel@cise.ufl.edu
cc: Nelson Abramson <pogtal@erols.com>, Kevin Puetz <puetzk@iastate.edu>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Mozilla M13 Release Build Available
In-Reply-To: <Pine.LNX.4.21.0001271619360.29611-100000@adsl-78-160-189.gnv.bellsouth.net>
Message-ID: <Pine.LNX.4.10.10001271557410.1888-100000@xpol.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It still seems to wait forever at
  	nNCL: registering deferred (0)

Maybe my machine is too slow (7200/90 with 16MB)???

- Ramprasad

Kevin: I tried your new libelfs too

On Thu, 27 Jan 2000 phandel@cise.ufl.edu wrote:

> On Thu, 27 Jan 2000 ramp@oddjob.uchicago.edu wrote:
>
> > To get the required libelf.so.0 do the following
> >
> > # cd /usr/lib ; ls -l libelf.*
> >     This should show libelf.a
> >
> > # ld -shared -o libelf.so.0 --whole-archive libelf.a
> >     will create the dynamic library needed.
> >
> > I went beyond this and stuff started happening but seemed to hang.
> > Maybe it was doing something?
>
> I had to also do this:
>
> (5) adsl 4:15pm /usr/lib> ln -s libstdc++-libc6.1-1.1.so.2 libstdc++-libc6.1-2.so.3
>
> ...and now it works perfectly, although I am seeing a lot of this error:
>
> nsLayoutHistoryState::GetState, ERROR getting History state for the key
>
> I tried compiling it myself from the source, using:
>
> ./configure --disable-mailnews --disable-tests --enable-x11-shm
> --enable-optimize --disable-debug --enable-stript-libs --disable-double-buffer
>
> ...and replacing -g -O2 with -O3 -fomit-frame-pointer, and it compiled
> fine and ran very quickly, although the version number keeps saying
> "1999122808" from
> dist/bin/chrome/navigator/locale/en-US/navigator.dtd:<!ENTITY
> buildId.label "Build ID: 1999122808">
> and
> xpfe/browser/resources/locale/en-US/navigator.dtd:<!ENTITY  buildId.label
> "Build ID: 1999122808">
> although I was careful to grab the latest nightly source tarball and then
> later the official M13 source tarball ... any ideas?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
