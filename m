Message-ID: <3D120573.4000305@embeddededge.com>
Date: Thu, 20 Jun 2002 12:40:19 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <20020619221532.F3C7A10301@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:


> So what is your suggestion if I want to provide a patch that supports
> some new hardware?

I personally always do it first in the new, development tree (2.5 in
this case), then move it into the current stable tree.  It isn't that
you don't ever put new things into the stable tree, you just can't treat
it as a development tree.  Any "cosmetic" changes shouldn't be done in
a stable tree.


> ..... And often enough the hardware is instable enough,
> so I don't need the additional thrill of an instable Linux kernel.

Well, that is a challenge but you are likely to have some similar hardware
that will provide a stability reference.  Anything new won't work better
than something that is proven.  The main reason I like doing the new hardware
in 2.5 is that way it is carried along as the software evolves.  I have seen
lots of updates lost in newer kernels because someone decided to "do it later",
then when it becomes the next stable kernel everyone is in a panic to get
their updates done :-)

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
