From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: consistent_alloc() revisited
Date: Sat, 20 Jul 2002 17:22:13 +0200
Message-Id: <20020720152213.10662@192.168.4.1>
In-Reply-To: <20020716021313.GQ22786@zax>
References: <20020716021313.GQ22786@zax>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>Arguably setting PageReserved is the Right Thing, since
>consistent_alloc() memory obviously shouldn't be swapped or paged.
>However, it's only relevant if the memory is mapped into userspace,
>and then a driver can set VM_IO on the vma to prevent this.

An other issue I had with AGP is, I think, killing the userspace
process mmap'ing some of this memory will cause the kernel to try
to free the pages if not PageReserved

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
