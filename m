Message-ID: <38F200CF.B4A07187@embeddededge.com>
Date: Mon, 10 Apr 2000 12:26:55 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Pavel Roskin <pavel_roskin@geocities.com>,
        "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Software Emulation Exception...
References: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com> <38EE0267.FB881499@embeddededge.com> <kfywvm6s3dz.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> Well, it also happens to be typical to the MM problem solved by
> the patches at http://www.zeta.org.au/~linsol/.....

That's pretty interesting, since the Software Emulation trap is
caused by fetching trash from memory, and the MMU changes are to
properly track dirty data pages.  I don't buy it.  All you did
by adding these changes was eliminate (or change) the data TLB
miss timing.  Have you ever looked at the 8xx bus when it gets
a TLB fault?  Pretty damn weird.  I've seen several external devices
not behave properly because of this.


> And by Pavel's description it's almost 100% certain that the MM
> bug is the problem.

Well, almost 100% doesn't cut it for me.  If you can't determine the
actual cause of the problem and prove it has been corrected, it is
still broken.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
