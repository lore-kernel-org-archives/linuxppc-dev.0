From: Rob Cascella <rob@schizophrenia.dfjp.com>
Message-Id: <200005040057.UAA02407@schizophrenia.dfjp.com>
Subject: Re: KDE 2.0 compilation problems
To: jpgrimes@rainbow.uchicago.edu (john peter grimes)
Date: Wed, 3 May 2000 20:57:37 -0400 (EDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.SGI.3.96.1000503191045.17758D-100000@rainbow.uchicago.edu> from "john peter grimes" at May 3, 0 07:24:27 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't know if it's related or not, but I've been trying to compile
something with g++ and have been getting an error message saying that
the compiler couldn't create executables.  I tried recompiling gcc,
but it didn't seem to help.  And, now that I think about it, I'd like
to try to resolve this issue, so, can anyone help me with this?  I'd
appreciate it..


<
< I was wondering if anyone had tried to compile KDE 2 lately.  I'm trying
< with yesterdays source and I get the error below in
< kdelibs/khtml/css
<
< I've got an almost standard linuxppc 2000 install which uses gcc-2.95.2-1g
<
< I can't find a report of this error on the kde web pages and looking at it
< I'm almost curious if it could be a problem with gcc for ppc (this file
< takes forever to compile) or some other ppc specific issue.
<
< Is anyone else compiling kde2, this is my first attempt.
< 					Thanks,
< 					John
<
<
<
< g++ -DHAVE_CONFIG_H -I. -I. -I../.. -I../../kimgio -I../../kio
< -I../../dcop -I../../khtml -I../../khtml/misc -I../../khtml/css
< -I../../khtml/dom -I../../khtml/xml -I../../khtml/html -I../..
< -I../../dcop -I../../kdecore -I../../kdeui -I/opt/qt-2//include
< -I/usr/X11R6/include -I/opt/kde2/include -O2 -fno-exceptions -fno-rtti
< -fno-check-new -Wall -pedantic -W -Wpointer-arith -Wmissing-prototypes
< -Wwrite-strings -Wno-long-long -fno-builtin -I/opt/kde2/include
< -I/opt/qt-2//include -I/usr/X11R6/include -frtti -fexceptions -c
< cssstyleselector.cpp  -fPIC -DPIC -o cssstyleselector.lo
< /tmp/ccjLaeTV.s: Assembler messages:
< /tmp/ccjLaeTV.s:17155: Error: operand out of range (33300 not between
< -32768 and 32767)
< /tmp/ccjLaeTV.s:17173: Error: operand out of range (33232 not between
< -32768 and 32767)
< /tmp/ccjLaeTV.s:17177: Error: operand out of range (33216 not between
< -32768 and 32767)
< /tmp/ccjLaeTV.s:17215: Error: operand out of range (33092 not between
< -32768 and 32767)
< /tmp/ccjLaeTV.s:17221: Error: operand out of range (33068 not between
< -32768 and 32767)
< make: *** [cssstyleselector.lo] Error 1

--
Rob Cascella  <rcascella@dfjp.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
