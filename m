Message-ID: <D73A25AA6E54D511AD74009027B1110F3C066A@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: question about first packet received by mpc8260
Date: Fri, 14 Feb 2003 16:24:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've done a search of the mailing list but I did not find anything related
to my question.  I have found on my companies MPC 8260 board that the first
packet sent to the Ethernet when initialized is never received.  At first I
thought the network interface had not come up fully so I put a large delay
between the FCC3 Ethernet init and the reading for the first packet.  Also,
I have tried reading packets for several seconds then sending it a packet,
it still does not receive it.  It seems to receive every packet after the
first one.  Has anyone seen something like this.

Thank you,
Steven Blakeslee

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
