Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2BFBDDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 15:51:38 +1100 (EST)
Date: Thu, 7 Feb 2008 05:51:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: asm-offsets.c
Message-ID: <20080207045129.GA4324@lst.de>
References: <47AA8C7D.3030109@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47AA8C7D.3030109@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 06, 2008 at 11:43:41PM -0500, Sean MacLennan wrote:
> I just did a git pull of Josh's tree, and 
> arch/powerpc/kernel/asm-offsets.c does not compile. I have only been 
> glossing over the linuxppc-dev emails, so forgive me if this already 
> came up.

I have the same problem with current powerpc.git.  At least it's a
different problem from yesterdays kernel/module.c not compiling :)
