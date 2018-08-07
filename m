Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kw9R2Jr1zDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 10:18:51 +1000 (AEST)
Message-ID: <53554e339b334b47d5822fb5219d5c878674b33c.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date: Tue, 07 Aug 2018 10:18:07 +1000
In-Reply-To: <20180807024503-mutt-send-email-mst@kernel.org>
References: <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
 <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
 <20180807002857-mutt-send-email-mst@kernel.org>
 <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
 <20180807024503-mutt-send-email-mst@kernel.org>
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

On Tue, 2018-08-07 at 02:45 +0300, Michael S. Tsirkin wrote:
> > OK well, assuming Christoph can solve the direct case in a way that
> > also work for the virtio !iommu case, we still want some bit of logic
> > somewhere that will "switch" to swiotlb based ops if the DMA mask is
> > limited.
> > 
> > You mentioned an RFC for that ? Do you happen to have a link ?
> 
> No but Christoph did I think.

Ok I missed that, sorry, I'll dig it out. Thanks.

Cheers,
Ben.
