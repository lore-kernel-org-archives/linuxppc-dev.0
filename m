Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Armin" <akuster@pacbell.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ibm_ocp_enet.c - PHY implementation requirements?
Date: Tue, 7 May 2002 22:03:59 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFAEKJDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CD7F783.8070704@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> There are a few stubs for the zmii bridge

I guess I am confused about how to create stubs. I looked at the code and it
appears that it wants to schedule mii functions to be completed for config,
ack, shutdown, ... I didn't see anything in the list processing that would
avoid the queue process. For instance, if you wanted to just initialize the
phy_status field from the config(), how could you do this without having it
go into the mii_queue processor? (setup for 100Mb, Full-Duplex)

> The MII functions can most likely be placed into it's own file and you
> might want to think about creating  a spi.c file for its implementation.

I totally agree.

>   This would allow us to have them be complied in depending on what mode
> is configured. The questions is can we come up with a common api to mii
> & spi?

The phy_info structure looks general enough. It is the function list
processing that concerns me. I will think about it tomorrow when the brain
is a little clearer. (and I have to come up with a viable solution)

THX


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
