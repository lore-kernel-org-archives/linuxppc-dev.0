Return-Path: <SRS0+04cdd449c1b762fe1908+1270+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03809DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 05:59:39 +1100 (EST)
Date: Wed, 14 Feb 2007 18:59:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.21-rc1 1/5] ehca: reworked irq handler to avoid/reduce
	missed irq events
Message-ID: <20070214185907.GA15105@infradead.org>
References: <200702141740.48286.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702141740.48286.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, h.carstens@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 05:40:47PM +0100, Hoang-Nam Nguyen wrote:
> Hi,
> here is a patch for ehca with the reworked irq handler.
> Thanks
> Nam

This looks okay to me (and sorry for new replying earlier to you private
mail)
