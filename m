Date: Fri, 14 Nov 2003 08:28:54 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jon Masters <jonathan@jonmasters.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx ports
Message-ID: <20031114082854.A23689@home.com>
References: <3FB4D07C.4010909@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FB4D07C.4010909@jonmasters.org>; from jonathan@jonmasters.org on Fri, Nov 14, 2003 at 12:54:20PM +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 14, 2003 at 12:54:20PM +0000, Jon Masters wrote:
>
>
> Hi there,
>
> Several people seem to think I was after advice on a port to use or
> asking for help doing one etc.
>
> For the record I am not in this current thread of conversation asking
> for those things but I am trying to find out how we can get the stock
> official kernel distributed by kernel.org to reflect some of the changes
> which have been made.

Post patches versus the BK linux-2.4 tree here so they can be discussed.
If they are suitable for merging upstream (Paul is happy) then they will
be moved into the for-marcelo-ppc tree.  This is a slow process unless
the changes are straightforward bug fixes or cleanups.

Merging patches into linuxppc-2.4 is much quicker and allows a wider
audience to test significant changes to help determine if they are
suitable to go upstream.  Stuff will get merged from linuxppc-2.4
upstream over time.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
