Date: Sat, 18 Sep 1999 12:39:17 -0700 (PDT)
From: Brian C Burke <bcburke@socrates.berkeley.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: libstdc++-2.10.0-0 issues
Message-ID: <Pine.LNX.4.10.9909181205440.694-100000@bigcat.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In attempting to install libstdc++-2.10.0-0c.ppc.rpm from the
KDE-1.1.2 rpms packaged by Franz Sirl I encounter this error:

	error: failed dependencies:
        	libstdc++ = 2.9.0 is needed by egcs-c++-1.1.2-12c

I have a R5 system set up with all the development software.  I can
compile working kernels, etc. and I do not want to break it.  Is it safe
to force an install of libstdc++-2.10.0-0, or do I need to update my
development packages.  If so what versions of egcs, gcc, etc are
compatible with libstdc++-2.10.0-0c.

Thank you,
Brian


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
