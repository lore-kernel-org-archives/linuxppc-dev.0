Return-Path: <SRS0+9585c4e39412ddbfd682+1236+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2D99DE158
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:21:30 +1100 (EST)
Date: Thu, 11 Jan 2007 19:21:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH/RFC 2.6.21 4/5] ehca: queue pair: remove use of do_mmap()
Message-ID: <20070111192124.GC24623@infradead.org>
References: <200701112009.08712.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701112009.08712.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org,
	hch@infradead.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 08:09:08PM +0100, Hoang-Nam Nguyen wrote:
> Hello Roland and Christoph H.!
> This is a patch for ehca_qp.c. It removes all direct calls of do_mmap()/munmap()
> when creating and destroying a queue pair respectively.

Looks good.
