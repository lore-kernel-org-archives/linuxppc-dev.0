Message-Id: <5.1.0.14.2.20020613180327.02e11f68@pop.prodigy.net>
Date: Thu, 13 Jun 2002 18:25:11 -0700
To: David Gibson <david@gibson.dropbear.id.au>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Cc: Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020614002419.GM4228@zax>
References: <20020613215635.GB13541@opus.bloom.county>
 <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
 <20020613205824.GX13541@opus.bloom.county>
 <3D0912F4.4020300@embeddededge.com>
 <20020613215635.GB13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:24 PM 6/13/2002, David Gibson wrote:
>That's right.  But I think the patch below is a better fix for the
>problem.  It makes consistent_alloc()/consistent_free() just do the
>right thing for both cache coherent and cache non-coherent processors,
>so we can get rid of the ifdef in pci_alloc_consistent() and
>pci_free_consistent().

So, kmalloc will allocate non-cacheable memory?

I seriously doubt it (actually I've just tested it:).

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
