Date: Tue, 28 Nov 2000 16:33:46 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Dan Malek <dan@mvista.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
In-Reply-To: <3A242BE5.C34D48FC@mvista.com>
Message-ID: <Pine.GSO.4.21.0011281625590.493-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 28 Nov 2000, Dan Malek wrote:

> I just checked in the newer driver that will properly do this on
> the EST board with the National PHY in the CTX-1170 gizmo.  If for
> some reason this doesn't work, just modify mii_discover_phy_poll() to
> set 'phy_duplex' to '1'.
>
Thank you very much.

> I checked this into linuxppc_2_5 BitKeeper on FSM Labs.  My 2.3/2.4
> kernel is broken and I need to clone a new tree before I can make
> changes.  That will take a little while......
>

Ok.  Do you know if there is anonymous bk access to the linuxppc_2_5
tree?  If so, on what port?  http://www.fsmlabs.com/linuxppcbk.html
doesn't mention it and I would like to play with it if possible.

As an off topic side note, wouldn't it make sense for there to be a common
MII library for all linux network drivers to share?  Is this not possible,
or has no one volunteered yet?

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
