Message-ID: <20000515063333.3612.qmail@web1705.mail.yahoo.com>
Date: Sun, 14 May 2000 23:33:33 -0700 (PDT)
From: Gabriel Ricard <g_ricard@yahoo.com>
Subject: Re: Lombard hard freeze during long compile with mem>64
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well that certainly is odd. I have setup a loop
compiling the kernel (without using any -j arguments
to make to provoke it) and it locked up on the second
build. It *COULD* very well be a memory problem,
however, if it is I'd be more inclined to blame it on
the 64MB that came with the Lombard, rather than the
128MB Kingston memory module I added. IMHO, Kingston
makes some of the best RAM out there.

I do find it interesting that you are not using the
400MHz model, and (I believe) that those of us having
the problems are. Am I wrong about this?

As for overheating, I have never had my fan come on
while under linux, even after running my powerbook ,
which gets often used as a desktop, for long periods
of times. Granted I am not playing quake 3 in
LinuxPPC... (yet?)

So, is it a memory issue or a cpu issue?


--- jeramy b smith <ultrapenguin@netscape.net> wrote:
>
> One of the people having the problem said they could
> reproduce the hardlock if
> they recompiled gnomehack several times. Here is
> some data I have collected.
>
> Using the vanilla linuxppc 2k kernel I have been
> doing some lengthy compiles
> (kde 1.9). One of my package builds went 2.5 hours.
> I have seen no problems
> and I have been running the entire time without a
> reboot. I have compiled all
> of kde 1.9 and I had to rebuild one of the lengthier
> packages 3 times.
>
> I did try to compile gnomehack and it was fun to
> play afterwards although it
> segfaulted after about 15 minutes.
>
> By the way, I did all of my building with full helix
> gnome running, several
> rxvts open, netscape running, and while talking in
> #mklinux with xchat. I also
> ran gaim for a while during this period.
>
> I am using a vanilla 2k install with a May build of
> Franz Sirl's gcc. My
> lombard is a 300 or 333 with 192 megs of ram.
>
>
> I am starting to doubt that this is a kernel level
> issue and I am starting to
> look at more likly culprits. Perhaps overheating or
> some other odd problem.
> Perhaps cheap memory modules.
>
>
>


=====
Gabriel Ricard
g_ricard@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
