Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE60DDE029
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:51:45 +1100 (EST)
Date: Fri, 26 Jan 2007 03:50:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.21 1/4] ehca: fix improper use of yield with spinlock
	held
Message-ID: <20070126025049.GB18537@lst.de>
References: <200701240010.37540.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701240010.37540.hnguyen@linux.vnet.ibm.com>
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

On Wed, Jan 24, 2007 at 12:10:36AM +0100, Hoang-Nam Nguyen wrote:
> Here is a patch for ehca_cq.c that fixes improper use of yield
> with spinlock held.

Btw, please don't forget to replace the yield call with a proper
condition for 2.6.21.
