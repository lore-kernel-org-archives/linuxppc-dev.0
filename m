Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F388FDDF27
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 00:14:36 +1000 (EST)
Date: Tue, 3 Jul 2007 16:13:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to handle patches that cross maintainers?
Message-ID: <20070703141351.GB18565@lst.de>
References: <4BEFAFC6-3346-4F29-B1C5-377952E3FBBF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BEFAFC6-3346-4F29-B1C5-377952E3FBBF@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 03, 2007 at 04:01:20AM -0500, Kumar Gala wrote:
> Andrew,
> 
> I was hoping to get your input on how to handle patches that cross  
> maintainers.  I've got a patch that is pretty PPC specific, but  
> happens to touch some drivers as well.

I think the real question is why the heck does it touch those drivers?
:)
