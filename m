Message-Id: <5.0.0.19.2.20000911215300.01e82aa0@mail.munich.netsurf.de>
Date: Mon, 11 Sep 2000 22:42:56 +0200
To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Roles for distributions
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v0311071db5e2dce88539@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 21:04 11.09.00, Hendricks, Kevin wrote:
>If people regularly do builds, and do "make check" then errors will appear
>near in time to recent patches and things (sort of like Linus's only give
>me small patches approach) that can tell the maintainers that something is
>amiss.  That makes any bugs much easier to find.  My last glibc 2.1.3 patch
>was found by doing regular builds to compare different glibc releases and
>it was easy to see that Ulrich's post 2.1.3 release breakage was the
>culprit.
>
>I can't help fix things if I don't know its broken.  That is why people
>doing regular builds, even if that aren't as skilled as Dan, or David, or
>Gary or Franz would surely help.

Actually the really time consuming part is hunting down the bugs, but
regular builds certainly help to narrow down the time a bug happened "it
passed all the tests yesterday, but today it fails test XYZ". I doing
nearly daily builds of the GCC mainline, and sporadic builds of binutils
(which usually remains stable for Linux/PPC currently) and glibc (where the
2.1 branch is more or less dead, and the 2.2 stuff slowly reaches stability).

Bug hunting is usually quite easy for bugs during "make check", the really
nasty stuff are things like "program XYZ doesn't behave like before if run
on glibc-2.2", especially if a lot of large shared libraries are involved.
Eg. I have now spent 3 or 4 evenings trying to track down the "gdm doesn't
work on a xf4 compiled against glibc-2.2 headers" reported by Jack, easily
reproducible with the gtk+ "tree" example running as root. Still I didn't
get to far tracking the bug down, cause I'm wading in megabytes of xf4 and
gtk+ code, I nearly know nothing about :-(. It "feels" like a bug in
glibc's str*/mem* macros/functions, but I haven't got to a point where I
can observe the bug and act on it.
_That_ is the most annoying part where some help is most welcome :-).
Unfortunately it requires quite some knowledge :-( and the ability to cope
with using beta software for main components like glibc.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
