Date: Tue, 5 Dec 2000 12:36:43 -0500 (EST)
From: Alex Avriette <alex@macachu.yi.org>
Reply-To: alex@cosmo.allay.net
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: alex@cosmo.allay.net, linuxppc-dev@lists.linuxppc.org, max@trega.com
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction
 - sort of)
In-Reply-To: <00120517250700.01539@enzo.bigblue.local>
Message-ID: <Pine.LNX.4.10.10012051230170.22364-100000@macachu.ex-pressnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


And lo there was much discussion regarding:

> > void
> > log (const char *fmt, ...)

> This code looks OK. What environment? (gcc/glibc)

from glibcbug:

Host type: powerpc-redhat-linux-gnu
System: Linux macachu 2.4.0-test11 #5 Sun Nov 26 13:51:22 EST 2000 ppc
unknown
Architecture: ppc

Addons: crypt linuxthreads
Build CFLAGS: -g -O2
Build CC: gcc
Compiler version: 2.95.2 19991024 (release/franzo)
Kernel headers: 2.4.0-test11
Symbol versioning: yes
Build static: yes
Build shared: yes
Build pic-default: no
Build profile: yes
Build omitfp: no
Build bounded: no
Build static-nss: no
Stdio: libio


> > void vs_test ( const char *fmt, ...)

> This testcase is buggy (look at the printf!), if fixed it behaves as
> expected. You would have seen that if you compiled with -W -Wall!

whoops! (blush!) gotcha.

> > void nested_test ( const char *fmt, ...)

> This testcase is bogus since you miss the required va_start/va_end pairs. It
> misbehaves as expected.

let me check with the bsd guy, but AIR, it runs without the two pairs. i
could be wrong.

> I've tested this both with gcc-2.95.3 and a recent gcc-2.97 snapshot. This
> looks a lot like your are still using egcs on PPC, don't do that, use
> gcc-2.95.[23] as the current distributions do.

all my experience writing c was in dos on borland c++, years ago. im
actually not sure about egcs, except that i get the error in gdb. how can
i be sure, and if i am, how can i switch?

thanks, franz.

alex

--
alex avriette [alex@cosmo.allay.net]

"No man who uses EMACS is deserving of love."
	Tom Christiansen <tchrist@perl.com>,
	_Perl Cookbook_, pp. 653


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
