Message-ID: <3984B243.AC88BF64@sympatico.ca>
Date: Sun, 30 Jul 2000 18:54:59 -0400
From: hendricks <kevin.hendricks@sympatico.ca>
Reply-To: khendricks@ivey.uwo.ca
MIME-Version: 1.0
To: "green@cygnus.com" <green@cygnus.com>
CC: "'khendricks@ivey.uwo.ca'" <khendricks@ivey.uwo.ca>,
        "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kaffe from cvs and some patches
References: <01BFFA2B.F8827460.green@cygnus.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Anthony,

If you are interested in kaffe, Godmar committed my changes and it
should build just fine under cvs.

I also built it using unix-pthreads (native linuxthreads) and it also
seems to work well (with a few minor build modifications).

As for libffi,I was using the cvs version 2.X.  As for threadsafety, I
am not sure that is the issue at all.

Given the sysdepCallMethod now exists for ppc, it should improve
performance over libffi (simply less overhead) (if you can get libffi to
work).


Try a cvs checkout of kaffe, it should build and work with both
unix-jthreads and unix-pthreads.

Kevin


Anthony Green wrote:
>
> Kevin wrote:
> > I built kaffe cvs using the cvs version of libffi and basicly it compiles
> but
> > does not really run any truly multi-threadsed apps
> > (see test/regressions/ThreadLocalTest.java for instance).
>
> libffi itself is thread safe.  I suspect that Kaffe is using it incorrectly.
>  Do you (or anyone else) know what the problem is?
>
> AG

--

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
