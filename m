Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8DF867B7F
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Apr 2006 01:28:23 +1000 (EST)
Date: Fri, 7 Apr 2006 17:28:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: arnd@arndb.de
Subject: Re: [PATCH 4/5] powerpc: export symbols for page size selection
Message-ID: <20060407152813.GA382@lst.de>
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060407150743.688538000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060407150743.688538000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 07, 2006 at 12:00:04AM +0200, arnd@arndb.de wrote:
> We need access to some symbols in powerpc memory management
> from spufs in order to create proper SLB entries.

One more reason to disallow modular spufs..
