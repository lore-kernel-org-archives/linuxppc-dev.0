Message-ID: <3BD625BB.C6FDA0DA@mvista.com>
Date: Tue, 23 Oct 2001 21:21:47 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Reducing glibc with mklibs.sh
References: <5.1.0.14.0.20011024095739.02d78c50@pop.gmx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >Note: I successfully reduced libpthread.so, also.
>
> How have you done the libthread? Standard compilation for glibc produces
> _pic only for libc on my system. My libm is still quite large.

I suggest you download the Hard Hat Linux (ftp.mvista.com) source rpm
for glibc.  I believe there is either a patch or a special "step" in the
%install section of the rpm spec file.

(It works for LOT, but is probably applicable to mklibs.sh)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
