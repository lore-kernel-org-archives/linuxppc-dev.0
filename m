Message-ID: <406B3CE0.2050600@embeddededge.com>
Date: Wed, 31 Mar 2004 16:49:20 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: John Whitney <johnw@sands-edge.com>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331181852.GA20127@lst.de> <A973047C-8357-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Whitney wrote:

 > ..... Shouldn't some care
> be taken to ensure that ANY virtual address passed to these routines
> maps to the correct physical (bus) address?

Don't go there.  This has been discussed over and over in the past
and as Matt said, this is not the place.  Read the archives if
you want to see these discussions.

The code works according to the documentation, and the implementation
of the pci_*/dma_* functions allows the flexibility we need to support
systems where the mapping is more challenging.  The kernel and drivers
should not be directly using virt_to_bus() and all of its cousins, they
should use the DMA mapping functions documented.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
