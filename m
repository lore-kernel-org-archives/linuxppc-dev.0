Message-ID: <3F5502CB.9030501@kegel.com>
Date: Tue, 02 Sep 2003 13:51:23 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: mss59@att.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory Profiling Tool
References: <200309021344.IAA18035@lists.linuxppc.org>
In-Reply-To: <200309021344.IAA18035@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


mss59@att.net wrote:
> Is there any memory profiling and leak detection tool available which
> works for both PPC and X86??

Here's what I know about.
1. There's a utility built into glibc which may be of some help:
http://www.gnu.org/manual/glibc-2.2.5/html_node/Allocation-Debugging.html#Allocation%20Debugging
but it's a bit minimal.

2. x86 only - valgrind, of course.  God's gift to x86 programmers.  Shame
it's not been ported to ppc.

3. libmudflap.  This is very promising; see
http://people.redhat.com/dnovillo/Papers/nordu2003-slides.pdf
http://www.linux.org.uk/~ajh/gcc/gccsummit-2003-proceedings.pdf
However, it's part of the SSA branch of gcc-3.4, so you'll need to use
something like http://kegel.com/crosstool to build it.
I am hoping to try this out on ppc sometime, but haven't yet.
FWIW, it's provided with Red Hat's taroon beta, so it must
be getting close to usable.

If you're debugging c++, you should also read
http://gcc.gnu.org/onlinedocs/libstdc++/debug.html
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
