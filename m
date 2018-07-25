Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bGN06NWKzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 23:31:27 +1000 (AEST)
Date: Wed, 25 Jul 2018 16:31:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, hch@infradead.org,
 linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com
Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180725162951-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-5-khandual@linux.vnet.ibm.com>
 <20180720160550-mutt-send-email-mst@kernel.org>
 <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2018 at 07:46:09AM +0530, Anshuman Khandual wrote:
> There is a redundant definition of virtio_has_iommu_quirk in the tools
> directory (tools/virtio/linux/virtio_config.h) which does not seem to
> be used any where. I guess that can be removed without problem.

It's there just to make tools/virtio build.
Try
	make -C tools/virtio/
In fact I see there's a missing definition for
dma_rmb/dma_wmb there, I'll post a patch.

-- 
MST
