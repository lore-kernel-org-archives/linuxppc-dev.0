Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41jkTK3jjjzF2D1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Aug 2018 11:58:27 +1000 (AEST)
Message-ID: <7fdcb1cb2900755a6534199a675483f60beb47fc.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date: Sun, 05 Aug 2018 10:53:33 +1000
In-Reply-To: <20180804081500.GA1455@infradead.org>
References: <20180801083639.GF26378@infradead.org>
 <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
 <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <20180803221634-mutt-send-email-mst@kernel.org>
 <20180804081500.GA1455@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-08-04 at 01:15 -0700, Christoph Hellwig wrote:
>   b) a way to document in a virtio-related spec how the bus handles
>      dma for Ben's totally fucked up hypervisor.  Without that there
>      is not way we'll get interoperable implementations.

Christoph, this isn't a totally fucked up hypervisor. It's not even
about the hypervisor itself, I mean seriously, man, can you at least
bother reading what I described is going on with the security
architecture ?

Anyway, Michael is onto what could possibly be an alternative approach,
by having us tell qemu to flip to iommu mode at secure VM boot time.
Let's see where that leads.

Cheers,
Ben.
