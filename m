Message-ID: <3B3EB24C.C7A72B8B@mvista.com>
Date: Sun, 01 Jul 2001 01:17:00 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: Paul White <pwhite@networkrobots.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
References: <Pine.LNX.3.95.1010629080637.13096A-100000@november.bhjjh.erols.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Justin (Gus) Hurwitz" wrote:

> I think that I've hunted down all of the dcbz instructions, but I should
> go and check align.c.

There is no reason to do this.  The behavior of these instruction on the
603e aren't any different than other processors.  If you know you are
operating on I/O space, use the memset_io/memcpy_fromio()/memcpy_toio()
and not the usual memory copy/set functions.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
