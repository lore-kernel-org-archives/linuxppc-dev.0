Date: Sat, 31 Mar 2001 15:16:06 -0500 (EST)
From: Bill Fink <billfink@capu.net>
To: Henry Worth <haworth@ncal.verio.com>
Cc: linuxppc-dev@lists.linuxppc.org, billfink@capu.net
Subject: Re: xine, ppc and illegal instructions 
In-Reply-To: <3AC418FD.2FA4AE67@ncal.verio.com>
Message-ID: <Pine.LNX.4.21.0103311202470.25703-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Thu, 29 Mar 2001, Henry Worth wrote:
>
> Bill Fink wrote:
> >
> >A theory why xine 0.4.01 would work on Henry's system but not on mine
> >was that Henry was running with a newer glibc (2.2.something).  I was
>
> Actually, I'm at 2.1.3 and 2.95.3 compiler, but the common
> denominator for those failing seems to be Debian distributions,
> whereas I'm LPPC Q4.

OK, maybe it's the compiler.  I'm running YDL 1.2.1 with:

gwiz% rpm -q -a | egrep 'gcc|glibc'
gcc-2.95.2-1i
gcc-c++-2.95.2-1i
gcc-objc-2.95.2-1i
gcc-g77-2.95.2-1i
glibc-2.1.3-15f
glibc-devel-2.1.3-15f

You're running gcc-2.95.3 while I'm running gcc-2.95.2-1i.

Well so much for that theory.  I just upgraded to gcc-2.95.3-2n from
LPPC 2000 Q4 and it didn't help.

How about shared libraries?  Here's the list of packages from my
system that provide shared libraries for xine (from ldd):

	glibc-2.1.3-15f
	XFree86-libs-4.0.2-2a
	imlib-1.9.8-1
	libjpeg-devel-6b-10
	libtiff-devel-3.5.4-5
	libungif-4.1.0-3
	libpng-devel-1.0.5-3
	zlib-1.1.3-6
	esound-0.2.20-0
	audiofile-0.1.9-3

Henry, could you please let me know what versions of the above you
are running on your system so I can compare?

I have a suspicion it might be an X problem although I can't say why
I feel that way.  I'm running using Xv on an ATY Rage128.

						-Thanks

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
