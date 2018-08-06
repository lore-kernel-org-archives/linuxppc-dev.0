Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kjPZ2m6rzF3HK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 02:13:38 +1000 (AEST)
Date: Mon, 6 Aug 2018 19:13:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, robh@kernel.org,
 srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
 Jason Wang <jasowang@redhat.com>, linuxram@us.ibm.com,
 linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, paulus@samba.org,
 joe@perches.com, david@gibson.dropbear.id.au,
 linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
 haren@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180806191111-mutt-send-email-mst@kernel.org>
References: <20180802235332-mutt-send-email-mst@kernel.org>
 <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
 <20180805032355-mutt-send-email-mst@kernel.org>
 <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
 <20180806163440-mutt-send-email-mst@kernel.org>
 <20180806152406.GA29020@infradead.org>
 <20180806190321-mutt-send-email-mst@kernel.org>
 <20180806161040.GA4675@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180806161040.GA4675@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2018 at 09:10:40AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 06, 2018 at 07:06:05PM +0300, Michael S. Tsirkin wrote:
> > > I've done something very similar in the thread I posted a few years
> > > ago.
> > 
> > Right so that was before spectre where a virtual call was cheaper :(
> 
> Sorry, I meant days, not years.  The whole point of the thread was the
> slowdowns due to retpolines, which are the software spectre mitigation.

Oh that makes sense then. Could you post a pointer pls so
this patchset is rebased on top (there are things to
change about 4/4 but 1-3 could go in if they don't add
overhead)?

-- 
MST
