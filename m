Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044652@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Gabriel Paubert'" <paubert@iram.es>
Cc: "'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
Date: Tue, 8 May 2001 10:43:43 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I think that we agree that my patch fixes a real bug, but that, sadly, it
> is _not_ the bug you are seeing. Given the "prevent interrups in atomic
> operation" patch that apparently fixes the bug, I looked for possibilities
> of stale reservations. Now your bug is even more puzzling...

Yes, I agree.  Like I said it definitely runs longer now than it did before,
but unfortunately shows the same symptom.  Here is a little more information
that I gleaned last night which may or may not be useful.

I noticed that arch/ppc/kernel/misc.S still had the (old?) assembly
functions for doing atomic operations.  They are similar but slighly
different to the inline functions in atomic.h.  I ran yesterday for about 4
hours with these "alternative" atomic functions, and I did not see the
failure.  I'm not sure if this was just a coincidence (the timing changed
slightly), or whether it indicates a problem with the inline atomic
functions.

> Can we get an oops trace if you hit it ? For now I'm puzzled.

Sure, I'll post it next time I get it.  (I already cleared the one I got
last night).

Regards,
Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
