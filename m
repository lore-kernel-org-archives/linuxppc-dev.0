Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 4/5] powerpc: export symbols for page
	size selection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20060407152813.GA382@lst.de>
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060407150743.688538000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060407152813.GA382@lst.de>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 11:21:56 +1000
Message-Id: <1144718517.19353.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-04-07 at 17:28 +0200, Christoph Hellwig wrote:
> On Fri, Apr 07, 2006 at 12:00:04AM +0200, arnd@arndb.de wrote:
> > We need access to some symbols in powerpc memory management
> > from spufs in order to create proper SLB entries.
> 
> One more reason to disallow modular spufs..

Why ? It's not problem as long as they are exported GPL only ...

Ben.
