Return-Path: <SRS0+8dd218c1a5062aad74f4+1208+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6037967D4C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 04:35:58 +1100 (EST)
Date: Thu, 14 Dec 2006 17:35:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/14] Spidernet DMA coalescing
Message-ID: <20061214173534.GA3452@infradead.org>
References: <20061213210010.GR4329@austin.ibm.com>
	<20061213210659.GA1915@austin.ibm.com>
	<20061214110517.GA13377@infradead.org>
	<20061214170737.GS4329@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061214170737.GS4329@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@gmx.de>,
	jgarzik@pobox.com, James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 14, 2006 at 11:07:37AM -0600, Linas Vepstas wrote:
> Being unclear on the concept, should a send a new version of this patch,
> or should I send a new patch that removes this?

For just the memset issue an incremental patch would be fine.  But given
the small mistake in the patch description a resend with the fixed
description mighrt be in order here.
