Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2234FDDFB3
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 18:58:16 +1000 (EST)
Date: Sat, 30 Jun 2007 10:58:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: powerpc stacktrace and lockdep support
Message-ID: <20070630085808.GA15386@lst.de>
References: <20070108135458.GA23395@lst.de>
	<1182898073.4769.6.camel@johannes.berg>
	<1182970829.4769.62.camel@johannes.berg>
	<1183047642.3735.0.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1183047642.3735.0.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 28, 2007 at 06:20:42PM +0200, Johannes Berg wrote:
> This one doesn't break 32-bit build by simply disabling irqtrace for
> 32-bit.

This looks really cool to me.  I'd love to see this in 2.6.23.
