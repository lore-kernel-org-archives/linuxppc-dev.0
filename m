In-Reply-To: <20040331215248.GB831@gate.ebshome.net>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331181852.GA20127@lst.de> <A973047C-8357-11D8-9FF0-000A95A07384@sands-edge.com> <20040331215248.GB831@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D2A86CD4-835F-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: John Whitney <johnw@sands-edge.com>
Subject: Re: Proposed changes to io.h
Date: Wed, 31 Mar 2004 17:07:38 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Please, read DMA-mapping.txt, it's quite clear on what memory is
> considered
> DMA'able.
>

Sorry, Eugene.  It just seemed odd that dma_map_single(), called with
the virtual address produced by dma_alloc_coherent(), would return the
wrong address.  Thanks for the insight.

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
