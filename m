From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15626.55392.839931.746121@argo.ozlabs.ibm.com>
Date: Sat, 15 Jun 2002 16:02:08 +1000 (EST)
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
In-Reply-To: <20020614153954.GL13541@opus.bloom.county>
References: <20020614042928.GK26146@zax>
	<20020614153954.GL13541@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini writes:

> My only concern is that is it a good idea to make a 'consistent_alloc'
> and 'consistent_free' functions for  cache-cohernet processors, which
> aren't doing what the name implies?  The only possible caller of these
> are pci_alloc_consistent and pci_free_consistent, in a cache-cohernet
> processor.

"Consistent" means "the cpu and the device see the same stuff in
memory".  On a cache-coherent system that is true of all normal
memory.  Surely that is obvious?

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
