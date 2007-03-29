Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E0FB9DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 00:37:32 +1000 (EST)
Date: Thu, 29 Mar 2007 09:52:52 -0500
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070329145252.GA23270@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
	<1174511149.5225.135.camel@goblue>
	<20070322175324.GA21120@lixom.net>
	<1175026241.1398.23.camel@goblue>
	<20070328155635.GA14356@lixom.net>
	<1175105842.1398.43.camel@goblue>
	<1175124183.32220.17.camel@localhost.localdomain>
	<1175175842.1398.54.camel@goblue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175175842.1398.54.camel@goblue>
From: olof@lixom.net (Olof Johansson)
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2007 at 08:44:02AM -0500, Jake Moilanen wrote:
> On Thu, 2007-03-29 at 09:23 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2007-03-28 at 13:17 -0500, Jake Moilanen wrote:
> > 
> > > One more try.
> > 
> > And patch is still mangled....
> 
> Hrm....I should just go back to Sylpheed.  
> 
> Unmangled version:
> 
> 
> There are many adapters which can not handle DMAing acrosss any 4 GB
> boundary.  For instance the latest Emulex adapters.  
> 
> This normally is not an issue as firmware gives dma-windows under
> 4gigs.  However, some of the new System-P boxes have dma-windows above
> 4gigs, and this present a problem.
> 
> During initialization of the IOMMU tables, the last entry at each 4GB
> boundary is marked as used.  Thus no mappings can cross the boundary.
> If a table ends at a 4GB boundary, the entry is not marked as used.
> 
> A boot option to remove this 4GB protection is given w/ protect4gb=off.
> This exposes the potential issue for driver and hardware development
> purposes.
> 
> Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
