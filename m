Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97E9CDDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 17:56:18 +1000 (EST)
Date: Fri, 14 Sep 2007 09:43:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 09/25] cell: remove DEBUG for spu callbacks
Message-ID: <20070914074332.GC18011@lst.de>
References: <1189751574.98527.127994196313.1.gpush@pokey>
	<1189751574.103973.353120224453.9.gpush@pokey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189751574.103973.353120224453.9.gpush@pokey>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 04:32:54PM +1000, Jeremy Kerr wrote:
> We don't want SPE programs to be able to flood the kernel log by
> invoking the SPE callback handler, so don't enable DEBUG for
> spu_callbacks.c by default.

Yeah, sounds sane.
