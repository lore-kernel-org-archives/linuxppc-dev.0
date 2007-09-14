Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7494ADDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 17:56:20 +1000 (EST)
Date: Fri, 14 Sep 2007 09:44:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 02/25] spufs: remove asmlinkage from do_spu_create
Message-ID: <20070914074456.GE18011@lst.de>
References: <1189751574.98527.127994196313.1.gpush@pokey>
	<1189751574.99308.205878694122.2.gpush@pokey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189751574.99308.205878694122.2.gpush@pokey>
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
> do_spu_create doesn't need the asmlinkage qualifier; remove it.

Ah, okay it's solved here.  Drop my earlier comment then.
