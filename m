Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42617DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 21:52:19 +1100 (EST)
Date: Wed, 28 Nov 2007 10:52:12 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: pseries (power3) boot hang  (pageblock_nr_pages==0)
Message-ID: <20071128105211.GB2238@csn.ul.ie>
References: <1195682111.4421.23.camel@farscape.rchland.ibm.com>
	<20071121220337.GB31674@csn.ul.ie>
	<1196105757.11297.11.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1196105757.11297.11.camel@farscape.rchland.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Memory Management List <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (26/11/07 13:35), Will Schmidt didst pronounce:
> 
> On Wed, 2007-11-21 at 22:03 +0000, Mel Gorman wrote:
> > On (21/11/07 15:55), Will Schmidt didst pronounce:
> > > Hi Folks, 
> > > 
> > > I imagine this would be properly fixed with something similar to the
> > > change for iSeries.  
> > 
> > Have you tried with the patch that fixed the iSeries boot problem?
> > Thanks for tracking down the problem to such a specific place.
> 
> I had not, but gave this patch a spin this morning, and it does the
> job.  :-)  

Brilliant.

> I was thinking (without really looking at it), that the
> iseries fix was in platform specific code.   Silly me. :-)
> 
> So for the record, this patch also fixes power3 pSeries systems.
> 
> fwiw:
> Tested-By:  Will Schmidt <will_schmidt@vnet.ibm.com>
> 

Thanks a lot for reporting and testing Will.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
