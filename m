Message-ID: <39AFCA3E.BE3FB08E@embeddededge.com>
Date: Fri, 01 Sep 2000 11:24:46 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Daris A Nevil <dnevil@snmc.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cpm_enet_down and MAC address change.
References: <081f01c013db$364aa100$1952df8d@SOYANG> <39AFAD3C.C849E398@snmc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daris A Nevil wrote:

> I have been promising myself that I would re-work the ethernet driver

So have lots of people.  Unfortunately, there haven't been any
embedded systems I have worked on that needed this, so it keeps
dropping down the list.

> ........  Another problem with the driver is that it
> will only work with a single enet port.

I am correcting that now.  Keep in mind that most 8xx processors
won't work with more that one SCC Ethernet......I finally have someone
providing hardware that will prove this ability.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
