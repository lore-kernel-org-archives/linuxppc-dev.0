From: phandel@cise.ufl.edu
Date: Wed, 9 Feb 2000 11:24:47 -0500 (EST)
To: "D.J. Barrow" <barrow_dj@yahoo.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user@lists.linuxppc.org
Subject: Speaking of Mozilla -> Bugs fixed!
In-Reply-To: <20000208222312.1905.qmail@web218.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0002081818200.2577-100000@adsl-78-160-189.gnv.bellsouth.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just tried grabbing the newest source code and compiling it, and both of
the major bugs (black screen on resize, and crash on click in url field)
have now been fixed.  I compiled them with CFLAGS = "-O3
-fomit-frame-pointer" and --disable-mailnews --disable-tests
--disable-debug --enable-optimize --enable-x11-shm --enable-strip-libs


Thanks,
Peter

--
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
