Message-ID: <3C84A17F.3020006@pacbell.net>
Date: Tue, 05 Mar 2002 10:44:15 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: Jim Duey <jduey@ccc-dcs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut networking problems
References: <3C837EED000002AE@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Duey wrote:
> I have a Walnut board that I've been working with for sometime.  I got it
> working fine with Linux, but the networking seems to be fragile.  For
> instance, I switch from a Ethernet switch to a hub and now the board won't
> boot over the network.  Also, it has never been able to use DHCP.  What are
> teh reasons for this fragility?  If I design the 405GP into my product, will
> it have the same problems or is this strictly a Walnut related issue?
>
> Jim
>
>
>
>

The Walnut requires DHCP 2 with patch level 5.  You should be fine using
linux

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
