Date: Sun, 21 Jul 2002 23:23:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: consistent_alloc() revisited
Message-ID: <20020721132340.GE22786@zax>
References: <20020716021313.GQ22786@zax> <20020720152213.10662@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020720152213.10662@192.168.4.1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jul 20, 2002 at 05:22:13PM +0200, Benjamin Herrenschmidt wrote:
>
> >
> >Arguably setting PageReserved is the Right Thing, since
> >consistent_alloc() memory obviously shouldn't be swapped or paged.
> >However, it's only relevant if the memory is mapped into userspace,
> >and then a driver can set VM_IO on the vma to prevent this.
>
> An other issue I had with AGP is, I think, killing the userspace
> process mmap'ing some of this memory will cause the kernel to try
> to free the pages if not PageReserved

Surely it shouldn't if VM_IO is set.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
