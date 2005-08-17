Return-Path: <SRS0+012e81371fdbb5a82166+724+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F418667FB0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 18:30:57 +1000 (EST)
Date: Wed, 17 Aug 2005 09:30:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050817083048.GA11892@infradead.org>
References: <20050816.203312.77701192.davem@davemloft.net>
	<032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
	linux-kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"Gala Kumar K.-galak" <galak@freescale.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2005 at 12:43:37AM -0500, Kumar Gala wrote:
> >I concur, in fact we should really kill that thing off entirely.
> 
> I'm all for killing it off entirely but got some feedback that on  
> i386 segment.h can be included by userspace programs.

No kernel headers can be included by userland anymore.
