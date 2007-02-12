Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc2-s21.bay0.hotmail.com (bay0-omc2-s21.bay0.hotmail.com
	[65.54.246.157]) by ozlabs.org (Postfix) with ESMTP id D8DB7DDD01
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 08:25:45 +1100 (EST)
Message-ID: <BAY117-F2427B141C77EDE2107B55CC8910@phx.gbl>
In-Reply-To: <GPECLCIGPLHEOMGPMCPACELEEGAA.edjubenville@adelphia.net>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: edjubenville@adelphia.net, linuxppc-embedded@ozlabs.org
Subject: RE: Finding devices with dynamic IP addresses
Date: Mon, 12 Feb 2007 16:25:41 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>From: "Edward Jubenville" <edjubenville@adelphia.net>
>I hope this isn't off topic here...
>
>My network will contain several ELDK-based devices configured with dynamic
>IP addresses (DHCP).  I need a way for any Windows PC on the subnet to
>locate the devices without prior knowledge of their IP address.  I'm hoping
>to find a peer-to-peer
>solution that doesn't involve a third party (DNS) server.


not sure if you can do a broadcast ping and look at the arp info on 
windows..but if I were to do this in linux, I'd do something like the 
following

ping -b 255.255.255.255

CTRL-C after a few seconds

then

arp

_________________________________________________________________
Invite your Hotmail contacts to join your friends list with Windows Live 
Spaces 
http://clk.atdmt.com/MSN/go/msnnkwsp0070000001msn/direct/01/?href=http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us
