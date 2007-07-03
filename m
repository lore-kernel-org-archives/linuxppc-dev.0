Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21944DDF05
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 00:13:31 +1000 (EST)
Date: Tue, 3 Jul 2007 16:13:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to 2.6.23 branch
Message-ID: <20070703141310.GA18565@lst.de>
References: <18057.57417.999506.887803@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18057.57417.999506.887803@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 03, 2007 at 03:36:09PM +1000, Paul Mackerras wrote:
>       [POWERPC] spufs: Add stat file to spufs

>       [POWERPC] spufs: Add spu stats in sysfs

These two should not go to Linus yet, they'll probably need quite a bit
of rework.
