Message-Id: <200106291751.f5THpK810528@stimpy.networkrobots.com>
Date: Fri, 29 Jun 2001 10:55:29 -0700
To: jtm@smoothsmoothie.com, linuxppc-embedded@lists.linuxppc.org
From: Paul White <pwhite@networkrobots.com>
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
In-Reply-To: <20010629113055.A30951@shamus.smoothsmoothie.com>
References: <3B3C30CD.34B20F02@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jay,

Basically, on any CPU, DMA requires either no cache, or at least a cache
coherent
system.  Cache Coherency is a two-part thing, the CPU must support it, the
memory (system) controller.  If the memory controller doesn't generate the
proper
cache coherency snoop cycles, the CPU still has no idea to flush or invalidate
cache lines.

Paul W.



At 11:30 AM 6/29/2001 -0500, jtm@smoothsmoothie.com wrote:
>
>On Fri, Jun 29, 2001 at 03:39:57AM -0400, Dan Malek wrote:
>>
>> jtm@smoothsmoothie.com wrote:
>>
>> > .... The buffer memory will get filled
>> > via DMA, and therefore must not be cached.
>>
>> Huh????  The 8260 is cache coherent, you don't need to do that.
>
>OK. I've had more experience with the 860, and just assumed the
>8260 had the same no cache requirement on DMA. Thanks.
>
>--
>Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
>monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
>		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_
>
>
-------------------------------------------------------------
Network Robots, Inc.         /--\               Paul H. White
                           / ____ \
4695 Chabot Dr. #200      / ( oo ) \       Software Developer
Pleasanton, CA 94588     /   ----   \             Engineering
(925) 924-8600           \   ----   /          (925) 580-4883
                          \  V--V  /
                           \      /
                             \--/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
