Message-ID: <3FD75312.7070701@embeddededge.com>
Date: Wed, 10 Dec 2003 12:08:34 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 TLB miss reduction
References: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Grandegger wrote:

> ....We
> can regain a few percent by using the kernel option CONFIG_PIN_TLB
> but we are thinking about further kernel modifications to reduce
> TLB misses. What comes into my mind is:

If you have a large application I doubt any kernel modification
will gain much.  It's the application causing the huge amounts
of tlb misses, you probably need to evaluate changes that will
reduce that.

It's always easy to pick on the kernel and make some changes
becaue it is a very static and well behaved application.  It
seems your biggest performance increase would come from the
analysis of the application and some redesign to improve its
use of system resources.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
