Message-ID: <3B79C1DA.9C8DA308@mvista.com>
Date: Tue, 14 Aug 2001 20:27:06 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: flush_dcache_range problems
References: <Pine.LNX.4.33.0108150015240.2590-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Justin (Gus) Hurwitz" wrote:

> Our driver works perfectly with L1 disabled.

I don't believe you :-).  You can't call dcb* instructions on
memory that isn't cache enabled......they crash.

> If you need any more info, let me know what you need, and I'll get it to
> you ASAP :)

I told you in the last message......backtrace and register dumps :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
