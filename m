Message-ID: <3B79AF73.59EB50C4@mvista.com>
Date: Tue, 14 Aug 2001 19:08:35 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: flush_dcache_range problems
References: <Pine.LNX.4.33.0108142014130.19084-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Justin (Gus) Hurwitz" wrote:
>
> Anyone have an idea as to why flush_dcache_range is crashing the kernel on
> my 603e based board?

Well, a little more information would be helpful.  First, you shouldn't
need to call it, so a backtrace would be useful.  The whole Linux panic
printout would be nice, so we can see what is in the registers......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
