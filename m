Return-Path: <olof@lixom.net>
Date: Fri, 7 Apr 2006 10:42:47 -0500
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] powerpc: export symbols for page size selection
Message-ID: <20060407154247.GJ952@pb15.lixom.net>
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060407150743.688538000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060407152813.GA382@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060407152813.GA382@lst.de>
From: Olof Johansson <olof@lixom.net>
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

On Fri, Apr 07, 2006 at 05:28:13PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 07, 2006 at 12:00:04AM +0200, arnd@arndb.de wrote:
> > We need access to some symbols in powerpc memory management
> > from spufs in order to create proper SLB entries.
> 
> One more reason to disallow modular spufs..

Yeah, what's the need for that, really? It needs to know so much of
kernel internals that it's getting silly to allow it to be a module.


-Olof
