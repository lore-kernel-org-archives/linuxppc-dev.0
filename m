Message-Id: <s0f8ff38.096@EMAIL>
Date: Sat, 17 Jul 2004 10:21:44 +0530
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why not kmalloc() ??
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here I put my understanding.

The hostalloc() function allocates space from "hostalloc space" which  is basically a small pre-allocated non-caches space that has been initialized before "kernel memory allocator" is initialized. This "hostalloc space" is "Cache coherent" and not available for the "kernel memory allocator". But, "hostalloc space" cannot provide large memory buffers.

dma_alloc_consistent() function can be used allocating large memory buffers which is non-cached.

How is dma_alloc_consistent() different from kmalloc() ? - Is it that dma_alloc_consistent() allocates memory which is non-cached and kmaloc() allocates cached memory?



Thanks
--
Rupesh S


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
