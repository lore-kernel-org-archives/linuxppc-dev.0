Message-ID: <3AEFED47.A685E105@india.infogain.com>
Date: Wed, 02 May 2001 16:49:35 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: question about dynamic dma?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a silly doubt about the pci-dma interface .
Is there any relevance of pci-dma interface on a
32 bit plateform? (though i understand its relevance on
64 bit plateform)
also in DMA-MAPPING.txt written that drivers using
this interface , should no more use virt_to_bus and
like stuffs.
what is the special significance of this?
Is it somewhere related to snooping during DMA
(as part of cache consistency protocol) ?
If anyone can explain this briefly , it will be
much helpful.
Regards..

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
