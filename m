Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Nov 2007 11:21:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTS Bytestrings Representation in /dts-v1/ files
Message-ID: <20071109002138.GE18592@localhost.localdomain>
References: <E1IpWlT-0007Qd-IX@jdl.com>
	<20071106231120.GG31367@localhost.localdomain>
	<E1Iplfp-0003WY-MB@jdl.com> <E1IqCtu-0000ZE-Vi@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IqCtu-0000ZE-Vi@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 08, 2007 at 01:18:50PM -0600, Jon Loeliger wrote:
> 
> Folks,
> 
> When the new DTS /dts-v1/ support is released Real Soon Now,
> it will support C-like literal constants.  Hex values will be
> prefixed with 0x, binary with 0b, and bare numbers will be
> decimal unless they start with a leading 0.
> 
> One outstanding question on which I'd like some feedback
> is the issue of bytestring value representation.
> 
> Currently they look like this:
> 
>     stuff = [ 0b 31 22 de ea ad be ef ];

Or, equivalently, like this:
	stuff = [0b3122deeaadbeef];

I think it's important to be aware of the more compact form when
considering whether to change the representation.

> One opinion is to have them continue to look like that
> and be in hex only.
> 
> Another opinion is to allow the new, consistent  C-style
> literals and expressions so that one could have:
> 
>     new_stuff = [ 0x31 49 '1' 23 17 ];
> 
> Opinions?
> 
> Thanks,
> jdl

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
