From: W4OQM@aol.com
Message-ID: <35.3d9791b.2629dbbd@aol.com>
Date: Sat, 15 Apr 2000 10:50:37 EDT
Subject: Re:  zeroing of bss segments
To: linuxppc-embedded@lists.linuxppc.org, kd@flaga.is
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anything been added to glibc that was written in C++?  If so, static
objects may exist that aren't being initialized because constructors aren't
being called.

Charlie

Charles A. Wells
c.wells@ieee.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
