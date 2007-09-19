Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc1-s34.bay0.hotmail.com (bay0-omc1-s34.bay0.hotmail.com
	[65.54.246.106]) by ozlabs.org (Postfix) with ESMTP id 86392DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 23:54:40 +1000 (EST)
Message-ID: <BAY101-F3306F36C70FAA4D450C466BEB90@phx.gbl>
From: "- Reyneke" <reynekejunk@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Eth1 init and link status
Date: Wed, 19 Sep 2007 13:54:35 +0000
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

HI,

We've run into a bit of an odd problem and we are not sure where to go and 
look for the cause.

We have some 440EPx based hardware with two GIG-Ethernet ports using RGMII 
and 2x ET1011C PHY's. Problem is that eth1 will only initialise correctly 
(i.e. receive and transmit) if eth0 has a link. Eth0 always work OK, 
regardless of eth1 status. Eth1 will work OK if eth0 has a link (i.e. 
initialised) at time of setup. Once initialised, eth0 status is irrelevant. 
All this is during Linux boot process.

Any ideas?

We can access PHY registers via u-boot (mii commands). Same 1Gig link speed 
is used on both ports. Linux kernel is 2.6.19.

Regards
   Jan Reyneke

_________________________________________________________________
Can you see your house from the sky? Try Live Search Maps 
http://maps.live.com
