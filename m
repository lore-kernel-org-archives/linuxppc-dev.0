Date: Wed, 31 Jul 2002 11:39:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ralph Blach <rcblach@us.ibm.com>
Cc: akuster@dslextreme.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Changes to "The plan"
Message-ID: <20020731013958.GI27711@zax>
References: <OFA1123D85.667B22FB-ON85256C06.004182DD@raleigh.ibm.com >
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFA1123D85.667B22FB-ON85256C06.004182DD@raleigh.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 30, 2002 at 08:02:42AM -0400, Ralph Blach wrote:
>
> Armin
>
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
>                   .
>                   .
>                   .
>       NPE405L
>        .
>        .
>        .

It's not clear to me what you're proposing.  Are you talking about the
layout of the Config.in options, the layout of the .c files in various
directories or the call structure of the platform initialization code?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
