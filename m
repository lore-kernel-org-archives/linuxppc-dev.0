From: duncanp@research.canon.com.au
Date: Tue, 25 Jan 2000 15:33:56 +1100 (EST)
Subject: Re: Embedded planet 860T CLLF HELP!
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3885EA14.920A68A0@netx4.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Message-Id: <20000125043638.22DD31B3F8@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 19 Jan, Dan Malek wrote:
> I just placed the latest MPC860T FEC driver on ppc.kernel.org.

This works well for me - thanks. I had some troubles when
auto-negotiate was enabled - the PHY decided it was running at 100MBps,
but the link did not come up. Forcing it to 10MBps worked around it - i
think this may have something to do with the switch i had the board
plugged into.

> This seems to work with the Embedded Planet CLLF.  It is a
> pretty bad hack, as the driver should really determine many
> of the things in #ifdef's dynamically.
>

If you haven't done any more work on this, i'll be happy to have a look
at neatening things up.

Dunk.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
