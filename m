Message-ID: <3E395B40.9090506@imc-berlin.de>
Date: Thu, 30 Jan 2003 18:05:04 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	laurent.pinchart@capflow.com, dan@embeddededge.com
Subject: was: FEC on MPC860T & race condition
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

in October 2001 (!) there were two threads, one was "FEC on MPC860T & race
condition" and the other was "Problem using FEC on a860T"

You, Laurent, told us about a race condition.
You, Dan, first claimed, it was already fix but mentioned later that the patch
was somehow lost.

Now I have this problem as well and realised that in 2.4.20 the
"mii_link_interrupt interrupt handler is still registered before the
PHY chip is initialized".

Are there any plans to fix that?
Laurent, did you fix taht for your board properly or just as a work around?

Thanks a million,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
