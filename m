Message-Id: <199904210043.UAA18581@mail-2.global2000.net>
Date: Tue, 20 Apr 1999 20:43:44 -0400
Subject: Re: Apple's "Darwin Streaming Server"
From: "AArthur" <arthur99@global2000.net>
To: Grant Bayley <gbayley@ausmac.net>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Having played around with Quicktime 4 this morning and watched the BBC etc
> across the Internet, I was delighted to see that Apple have opensourced
> and released the source code for the streaming server itself.
>
> I downloaded it and read the FAQ - only problem is they use the funky
> NeXTStep-ish Makefile to build the thing and requires "modification of a
> handful of source files" to compile and run on "platforms other than Mac
> OS X Server".
>
> I realise this is off topic, but it would be an interesting addition to
> Linux (and LinuxPPC in particular) to have this available in an
> easy-to-compile (./configure, anyone  :-) package..
>
> Has anyone started work on porting this?

Grant,

According to the Darwin developer list, people are working on porting it to
the x86 Linux, so that version should easily be able to bring to the PowerPC
with some work. Here are some messages regrading this:

----
>So who is interested in getting the Darwin Streaming Server to build under
>Linux i386?
>
>I've already gotten the QTFileLib to compile, but it looks like
>StreamingServer will require some actual work, and well, no time this
>week.

QTFileLib is easy to compile, altough not all things work right.

I'm thinking of changing the current way of having defines for each OS into
an autoconf - generated header. Unfortunately, I know nothing about how to
use autoconf.

As to the Server, I think it's best to build new makefiles. I think I'm
gonna use the GNUstep-make package, it seem suited to converstion of PB
projects.

Unfortunately, my spare time is small also. But I intend to do something
over the next two weeks.

Anybody else interested?

Pedro Ivo Tavares
----

Thanks,

AArthur
arthur99@global2000.nwt

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
