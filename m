From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15687.15829.736016.163916@argo.ozlabs.ibm.com>
Date: Wed, 31 Jul 2002 11:31:01 +1000 (EST)
To: "Ralph Blach" <rcblach@us.ibm.com>
Cc: akuster@dslextreme.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Changes to "The plan"
In-Reply-To: <OFA1123D85.667B22FB-ON85256C06.004182DD@raleigh.ibm.com >
References: <OFA1123D85.667B22FB-ON85256C06.004182DD@raleigh.ibm.com >
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach writes:

> It has always been my contention the the 4xx should be organized in the
> following structure
> Core
> Chip
> board
>
> This would tree would then reflect the reallity of chip design methodology.
> the 405 now has many variants
> so it would be
> 405 Core
>    Chip
>       405CR
>       405GP
>       Board
>                  Walnut

Wouldn't that make it more difficult to take advantage of the fact
that (for instance) the MAL and ENET are virtually identical on the
405GP and the 440GP?

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
