Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB08CDDEF7
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 09:56:43 +1000 (EST)
Date: Wed, 10 Sep 2008 01:56:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org, tony@bakeyournoodle.com
Subject: Re: build failure with current linus tree
Message-ID: <20080909235626.GA5254@lst.de>
References: <20080905010618.GA30278@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080905010618.GA30278@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2008 at 03:06:18AM +0200, Christoph Hellwig wrote:
> Current linus tree fail to build for me for a 64bit powerpc config with:

This is cause by

commit 7563dc64585324f443f5ac107eb6d89ee813a2d2
Author: Tony Breeds <tony@bakeyournoodle.com>
Date:   Tue Sep 2 16:50:38 2008 +1000

    powerpc: Work around gcc's -fno-omit-frame-pointer bug
