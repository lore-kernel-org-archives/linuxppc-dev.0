Date: Wed, 3 May 2000 19:24:27 -0500 (CDT)
From: john peter grimes <jpgrimes@rainbow.uchicago.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: KDE 2.0 compilation problems
In-Reply-To: <200004280042.RAA18722@pop3.ucdavis.edu>
Message-ID: <Pine.SGI.3.96.1000503191045.17758D-100000@rainbow.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was wondering if anyone had tried to compile KDE 2 lately.  I'm trying
with yesterdays source and I get the error below in
kdelibs/khtml/css

I've got an almost standard linuxppc 2000 install which uses gcc-2.95.2-1g

I can't find a report of this error on the kde web pages and looking at it
I'm almost curious if it could be a problem with gcc for ppc (this file
takes forever to compile) or some other ppc specific issue.

Is anyone else compiling kde2, this is my first attempt.
					Thanks,
					John



g++ -DHAVE_CONFIG_H -I. -I. -I../.. -I../../kimgio -I../../kio
-I../../dcop -I../../khtml -I../../khtml/misc -I../../khtml/css
-I../../khtml/dom -I../../khtml/xml -I../../khtml/html -I../..
-I../../dcop -I../../kdecore -I../../kdeui -I/opt/qt-2//include
-I/usr/X11R6/include -I/opt/kde2/include -O2 -fno-exceptions -fno-rtti
-fno-check-new -Wall -pedantic -W -Wpointer-arith -Wmissing-prototypes
-Wwrite-strings -Wno-long-long -fno-builtin -I/opt/kde2/include
-I/opt/qt-2//include -I/usr/X11R6/include -frtti -fexceptions -c
cssstyleselector.cpp  -fPIC -DPIC -o cssstyleselector.lo
/tmp/ccjLaeTV.s: Assembler messages:
/tmp/ccjLaeTV.s:17155: Error: operand out of range (33300 not between
-32768 and 32767)
/tmp/ccjLaeTV.s:17173: Error: operand out of range (33232 not between
-32768 and 32767)
/tmp/ccjLaeTV.s:17177: Error: operand out of range (33216 not between
-32768 and 32767)
/tmp/ccjLaeTV.s:17215: Error: operand out of range (33092 not between
-32768 and 32767)
/tmp/ccjLaeTV.s:17221: Error: operand out of range (33068 not between
-32768 and 32767)
make: *** [cssstyleselector.lo] Error 1




           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
