Message-ID: <3E39898E.5060804@embeddededge.com>
Date: Thu, 30 Jan 2003 15:22:38 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	laurent.pinchart@capflow.com
Subject: Re: was: FEC on MPC860T & race condition
References: <3E395B40.9090506@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> You, Laurent, told us about a race condition.
> You, Dan, first claimed, it was already fix but mentioned later that the
> patch
> was somehow lost.

IIRC, it was the usual problem of having it fixed in only one of the
two 2.4 trees.  I ensured both trees were made up to date.

> Now I have this problem as well and realised that in 2.4.20 the
> "mii_link_interrupt interrupt handler is still registered before the
> PHY chip is initialized".

The link interrupt is board design and PHY dependent.  I don't think there
is any one "right" way to initialize this interrupt handler.  If you have
something that isn't working to your liking, we may have to extend the
MII logic in some way to accomodate this.  Keep in mind that the existing
driver is likely working with other boards, and you don't want to break
those configurations.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
