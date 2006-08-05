Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA4CD679E1
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2006 22:46:36 +1000 (EST)
Date: Sat, 5 Aug 2006 14:45:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] SLB shadow buffer
Message-ID: <20060805124544.GB23494@lst.de>
References: <20060804055323.1A9BE679FB@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060804055323.1A9BE679FB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 04, 2006 at 03:53:19PM +1000, Michael Neuling wrote:
> This adds a shadow buffer for the SLBs and regsiters it with PHYP.
> Only the bolted SLB entries (first 3) are saved.

What is a SLB shadow buffer and why do we need it?  (I don't want to
question the patch but rather learn a little more about lowlevel ppc64
mmu details)
