To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cross compiling 8xx glibc on x86 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 16 Aug 2001 17:51:19 +0800."
             <5.1.0.14.0.20010816175113.00a4f0d0@pop.gmx.de>
Date: Thu, 16 Aug 2001 12:41:38 +0200
Message-Id: <20010816104143.3595010CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.0.14.0.20010816175113.00a4f0d0@pop.gmx.de> you wrote:
>
> >I've spend two days scouring the postings here and read much as I can find
> >on cross compiling
> >glibc with no fpu options. I've read all kinds of things, compiled for
> >hours, but nothing.  I've been somewhat unsuccessful,  I'm close to giving
> >up but that's why I'm writing.
>
> It took me two weeks until I gave up. This glibc is the trickiest part. I
> wish Wolfgang would write one - oh, a subset is already in PPCBoot. :)

Well, I did this nearly two years ago. You can find the build scripts
and patches I used on our FTP server. They still work. And  yes,  you
still  can  find  ALL  the old tarballs on the web, just use a search
engine.

> >I can compile glibc-2.2.3 (no mention of no fpu on configure) but bash segment
> >faults (actually init respawns to fast). I can get bash running if I use
> >the montavista compiled glibc* from their rpm. So I know that my
> >kernel/filesystem works etc. But still I want to compile glibc for 8xx myself.

Well, why don't you do it, then? If the MV version is fine  for  you,
and all you want to do is compile it yourself (just to burn some time
and  CPU resources, I guess), then grab the MV source RPM, unpack it,
and follow the build instructions in the RPM's "spec" file.

There is absolutely no magig involved. Anybody can do that. You don't
even have to understand what you're doing :-(

> A statically linked bash should work, even with the cacheline bug.

But only if it's linked against "clean" libs.


Ummm... I think you're just wasting your time. And ours.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Life. Don't talk to me about life.      - Marvin the Paranoid Android

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
