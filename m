Message-ID: <3E70B17E.9090507@embeddededge.com>
Date: Thu, 13 Mar 2003 11:27:42 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Stephan Linke <Stephan.Linke@epygi.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: question on howto use invalidate_dcache_range
References: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephan Linke wrote:

> After all is it realy neccessary to use invalidate_dcache range before giving the transmit buffer to the DMA?

The logically correct cache operation is to invalidate an incoming buffer
after the DMA has completed, and to (obviously) push an outgoing buffer
prior to starting the DMA.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
