Return-Path: <BATV+2e2b7d69833f9a8d01a8+5461+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kjsp3RSJzF3HK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 02:34:38 +1000 (AEST)
Date: Mon, 6 Aug 2018 09:34:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, robh@kernel.org,
 srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
 Jason Wang <jasowang@redhat.com>, linuxram@us.ibm.com,
 linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, paulus@samba.org,
 joe@perches.com, david@gibson.dropbear.id.au,
 linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
 haren@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180806163421.GA13077@infradead.org>
References: <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
 <20180805032355-mutt-send-email-mst@kernel.org>
 <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
 <20180806163440-mutt-send-email-mst@kernel.org>
 <20180806152406.GA29020@infradead.org>
 <20180806190321-mutt-send-email-mst@kernel.org>
 <20180806161040.GA4675@infradead.org>
 <20180806191111-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180806191111-mutt-send-email-mst@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2018 at 07:13:32PM +0300, Michael S. Tsirkin wrote:
> Oh that makes sense then. Could you post a pointer pls so
> this patchset is rebased on top (there are things to
> change about 4/4 but 1-3 could go in if they don't add
> overhead)?

The dma mapping direct calls will need a major work vs what I posted.
I plan to start that work in about two weeks once returning from my
vacation.
