Message-ID: <3CABEFCE.8050006@embeddededge.com>
Date: Thu, 04 Apr 2002 01:16:46 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jeremy Rosen <Jeremy.Rosen@au.thalesgroup.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <scac60f5.069@au.thalesgroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeremy Rosen wrote:


> can't we use the __GFP_DMA flag to specify that the area must have
> algnment enforced ?

Maybe, but that isn't its intended use.

> or did I misunderstand the use of this flag ?

This flag is used on architectures that have memory only accessible
from the processor, not from a DMA device, to ensure a DMA device
gets a memory bank that it can access.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
