Message-ID: <40EA7A74.1000408@fh-landshut.de>
Date: Tue, 06 Jul 2004 12:09:56 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC7455 DMA buffer strangeness
References: <Pine.LNX.4.58.0407051018590.388@corpster2>	 <1089102844.937.57.camel@localhost>  <40EA6739.2040408@fh-landshut.de> <1089106451.937.85.camel@localhost>
In-Reply-To: <1089106451.937.85.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Adrian!

When removing the line

vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

from my mmap() hook, DMA works as expected.

So my problem just transformed to "Differentiate mapping for Master Windows
(uncached) from mapping for DMA (cache coherent)".

Many a lot of thanks,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
