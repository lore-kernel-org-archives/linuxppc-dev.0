Message-ID: <3CFF19F6.50105@embeddededge.com>
Date: Thu, 06 Jun 2002 04:14:46 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMbench results for large page patch
References: <20020605070832.GF2630@zax> <20020606042939.GU2630@zax> <3CFF0F88.5020600@embeddededge.com> <20020606075732.GY2630@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> So are you ok with the notion of merging the large page stuff and
> abolishing CONFIG_PIN_TLB, once I've made iopa() and mapin_ram() less
> ugly than they are in that first cut?

I guess.  When I add my stuff I'll further clean it up :-)  There still
may be some latency sensitive applications that would benefit from some
pinned TLBs, but if we ever find them I guess we can fetch anything useful
from archives.  I'm glad this exercise actually found the couple of tlb
management bugs.  So much to do, so little time.........

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
