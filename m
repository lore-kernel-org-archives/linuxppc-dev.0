Message-ID: <3AFB078C.E2AA01A9@mvista.com>
Date: Thu, 10 May 2001 17:26:36 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Kuschak <brian.kuschak@skystream.com>
Cc: Gabriel Paubert <paubert@iram.es>, frowand@mvista.com,
	Eli Chen <eli@routefree.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <B25E2E5A003CD311B61E00902778AF2A02044671@SERVER1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:

> ....  I cannot find any code which does a regular store to the
> d_count variables.  All writes to these counters appear to use the atomic
> ops.

Yeah, but there are "atomic" ops/functions/macros that underneath
can do simple read/writes without using the PowerPC reservation
instructions (because they haven't been needed on other processors).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
