From: kd@flaga.is
Subject: Re: zeroing of bss segments
To: W4OQM@aol.com
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF1BB5880B.6A5C89DF-ON002568C3.0059B751@flaga.is>
Date: Sun, 16 Apr 2000 16:22:06 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, I doupt that the libc is written or will be written in C++.
The couse was fo all my troubles was that I forgot to remove memset.S, i.e.
I did not follow the instructions of the patch well enough.

Thanks, anyway,

K.D.





                    W4OQM@aol.com
                    Sent by:                                To:     linuxppc-embedded@lists.linuxppc.org, kd@flaga.is
                    owner-linuxppc-embedded@lists.li        cc:
                    nuxppc.org                              Subject:     Re: zeroing of bss segments


                    15.04.2000 14:50







Has anything been added to glibc that was written in C++?  If so, static
objects may exist that aren't being initialized because constructors aren't
being called.

Charlie

Charles A. Wells
c.wells@ieee.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
