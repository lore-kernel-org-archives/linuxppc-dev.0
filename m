Date: Wed, 29 Nov 2000 12:18:44 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Dan Malek <dan@mvista.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
In-Reply-To: <3A242BE5.C34D48FC@mvista.com>
Message-ID: <Pine.GSO.4.21.0011291213330.493-100000@eos>
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

I cracked open my CTX-1170 gizmo and it has a Lucent LU3X51FT-JE80 PHY in
it.  I manually set the phy_duplex to 1 and the phy_speed to 100, still
no dice.

Do you know what parts I need to modify in order to get the Lucent PHY
working too?  I am just looking for a few hints on what needs to be
done.  I'll be glad to try and do the "dirty" coding work.

Thanks.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
