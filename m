Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E779CDDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 03:12:09 +1100 (EST)
Date: Wed, 28 Nov 2007 16:12:02 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] powerpc: add hugepagesz boot-time parameter
Message-ID: <20071128161201.GA10916@csn.ul.ie>
References: <474CF68E.1040709@us.ibm.com> <200711280826.46820.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200711280826.46820.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, kniht@linux.vnet.ibm.com,
	Linux Memory Management List <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (28/11/07 08:26), Arnd Bergmann didst pronounce:
> On Wednesday 28 November 2007, Jon Tollefson wrote:
> > This patch adds the hugepagesz boot-time parameter for ppc64 that lets 
> > you pick the size for your huge pages.  The choices available are 64K 
> > and 16M.  It defaults to 16M (previously the only choice) if nothing or 
> > an invalid choice is specified.  Tested 64K huge pages with the 
> > libhugetlbfs 1.2 release with its 'make func' and 'make stress' test 
> > invocations.
> 
> How hard would it be to add the 1MB page size that some CPUs support
> as well? On systems with small physical memory like the PS3, that
> sounds very useful to me.
> 

Does the PS3 support 1M pages in hardware? When I last looked, the magic
ibm,segment-page-sizes file that described the supported pagesizes was
missing from the device tree. In this situation, the default sizes
become 4K and 16M because no other ones are advertised.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
