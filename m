From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B2362D@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Denx ELDK vs. Tool-Chain from Hollobaugh's book "Embedded Linux" 
Date: Tue, 28 Jan 2003 05:49:23 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello again,

I'm still slugging along here getting familiar with the GNU cross-compile
tool-chain and all that good stuff for my group's upcoming embedded 440GP
project.

We already have an ebony board (used for previous VxWorks product) and I'm
now waiting patiently for our bureaucrats to put through the order for a
BDI2000 so I can get something (U-Boot and then Linux) onto the board.

As I've played with different tool-chain options, I think I've narrowed it
down to the following.

1) Denx's ELDK
2) The tool-chain used in Craig Hollobaugh's book "Embedded Linux"

I'm not writing this to create a rivalry or incite a flame war, I'm just
looking for feedback on these two approaches. Optimally, if someone is
experienced with the pros/cons of both, I'd be really eager to hear what
your assessment is.

Also regarding (2), the book sets up the cross development environment on a
minimal debian linux box. I can't think of why, but is there any reason I
would have to stick with this distribution for my linux development server?

Thanks

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
