From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201130651.g0D6pws395601@saturn.cs.uml.edu>
Subject: Re: No cache control on ppc??
To: tas@mindspring.com (Timothy A. Seufert)
Date: Sun, 13 Jan 2002 01:51:58 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
	langausd@fachschaft.informatik.uni-stuttgart.de (Siggi Langauf),
	debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <p05101200b866cac2af77@[10.0.0.42]> from "Timothy A. Seufert" at Jan 12, 2002 09:36:57 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Timothy A. Seufert writes:
> At 4:39 PM -0500 1/12/02, Albert D. Cahalan wrote:

>> Bite off a small chunk of the image. Pulling a number out of
>> my ass, I'll say 128x128 pixels and 4 frames deep. This fits
>> nicely into my 1 MB L2 cache. Go with 64x64 for the MPC7410.
>
> You don't need to cut cache use by 1/4 on the 7410.  It's got almost
> the same L2 cache scheme as the 7400: they added one address bit so
> it can use up to 2 MB of SRAM, and it can now use half or all of the
> SRAM as memory instead of cache.  I think all of Apple's 7410 systems
> have 1 MB L2, and naturally Apple configures it all as cache.
>
> Were you thinking of the 7450?  It's the one that has 256 KB of
> on-die L2.  Keep in mind that it still has an interface for external
> cache, which is now L3.  Apple ships low end 7450 systems with no L3
> and medium to high range systems with 2 MB L3.

Yes, I meant the 7450.

Configuring the 7410 L2 or the 7450 L3 as SRAM would be going
way, way, too far I think. Not that it wouldn't be fun to try,
but then the box pretty much becomes a dedicated video player.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
