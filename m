Return-Path: <SRS0+ee4438df35e8a0bfe086+1243+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 523EEDDEE7
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 09:27:30 +1100 (EST)
Date: Thu, 18 Jan 2007 22:27:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH/RFC 2.6.21] ehca: ehca_uverbs.c: refactor ehca_mmap() for
	better readability
Message-ID: <20070118222720.GA5385@infradead.org>
References: <200701172312.14840.hnguyen@linux.vnet.ibm.com>
	<adavej4b1vi.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adavej4b1vi.fsf@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 18, 2007 at 10:56:01AM -0800, Roland Dreier wrote:
> I've kind of lost the plot here.  How does this patch fit in with the
> previous series of patches you posted?  Does it replace them or go on
> top of them?

It's a cleanup ontop of the actual fix.
