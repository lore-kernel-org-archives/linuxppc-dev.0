Message-ID: <3A36593C.1EE4CC5D@mvista.com>
Date: Tue, 12 Dec 2000 11:58:36 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
References: <Pine.GSO.4.21.0012120933330.24199-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:

> Are the explicit driver level calls to invalidate_dcache_range necessary
> on the receive side,

None of the cache management calls are necessary on the 8260 since the
cache is snooped.  We are mixing processor types in this discussion,
so be careful what you assume is necessary or works for a particular
driver.  They are different.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
