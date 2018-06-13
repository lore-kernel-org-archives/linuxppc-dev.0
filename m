Return-Path: <BATV+1e44ea8f521110dda36c+5407+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415H9h4QZ5zF0fW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 16:37:22 +1000 (AEST)
Date: Tue, 12 Jun 2018 23:37:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [patchV2 1/2] pci: introduce an extra method for matching in
 pci_driver
Message-ID: <20180613063710.GA30350@infradead.org>
References: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
 <1528871397-17917-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528871397-17917-2-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we successfull call ->probe twice on a device we have a much
deeper problem than we can fix in the PCI layer or shpchp.

Please explain the actual race or other condition that can lead to
this and report it to the driver core maintainer.
