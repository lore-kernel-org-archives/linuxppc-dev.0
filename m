From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [RFC] consistent_sync and non L1 cache line aligned buffers
Date: Tue, 15 Jul 2003 17:12:47 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C48A9@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> If you think about it, you will see that if you are doing DMA to an
> unaligned buffer, and some other unrelated part of the kernel is
> accessing another part of the cache line, you are in trouble no matter
> what sequence of cache flushes/invalidates/whatever you do.

I sort of assumed this was a given.  I'm used to things like
invalidating just 1514 bytes in a larger buffer, because I know
that it's safe.  However, I can agree with your sentiment, since
the actual reason that I made my invalidate routine safer was
because this was simpler than convincing some other programmers
how to do the right thing :-)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
