Return-Path: <BATV+d118b6de789876540797+4089+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 572D61A00B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 05:32:28 +1100 (AEDT)
Date: Mon, 3 Nov 2014 10:32:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] ipr: Convert to generic DMA API
Message-ID: <20141103183224.GB26428@infradead.org>
References: <201410302227.s9UMR8qs008773@d01av04.pok.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201410302227.s9UMR8qs008773@d01av04.pok.ibm.com>
Cc: James.Bottomley@HansenPartnership.com, hch@infradead.org,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks, I've applied patch 3 to drivers-for-3.18, and patches 1 and 2 to
core-for-3.19.
