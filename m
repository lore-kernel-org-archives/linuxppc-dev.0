Message-ID: <3A242BE5.C34D48FC@mvista.com>
Date: Tue, 28 Nov 2000 17:04:21 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
References: <Pine.GSO.4.21.0011281308070.493-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:

> So does this mean that a "complete" implementation would have a
> "command/status MII interface" or that a "complete" implementation does
> not need one?

The complete implementation should have a real command/status MII
interface.


> Can you help point me to where I need to write code that would initialize
> the FCC to do full duplex,

I just checked in the newer driver that will properly do this on
the EST board with the National PHY in the CTX-1170 gizmo.  If for
some reason this doesn't work, just modify mii_discover_phy_poll() to
set 'phy_duplex' to '1'.

I checked this into linuxppc_2_5 BitKeeper on FSM Labs.  My 2.3/2.4
kernel is broken and I need to clone a new tree before I can make
changes.  That will take a little while......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
