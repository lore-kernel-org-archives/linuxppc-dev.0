Message-ID: <3CABEDE9.5020404@embeddededge.com>
Date: Thu, 04 Apr 2002 01:08:41 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax> <3CAB3F0B.8080700@embeddededge.com> <20020403234051.GG21034@zax> <3CABC065.6050107@embeddededge.com> <20020404034809.GL21034@zax> <3CABD1E0.7020008@embeddededge.com> <20020404052349.GN21034@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Possibly a better approach would be to make the consistent_sync()
> function be more careful and flush rather than invalidate cachelines

That's basically what this patch does, with the overhead of always
writing instead of just invalidating.  We just went the whole circle
here, as this isn't a logically correct solution :-).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
