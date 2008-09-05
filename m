Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C008DDF37
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 11:36:15 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m851Zjo8020706
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 11:35:45 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m851aEwL303468
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 11:36:14 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m851aDjC019780
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 11:36:14 +1000
Date: Fri, 5 Sep 2008 11:36:04 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Jon Tollefson <kniht@linux.vnet.ibm.com>
Subject: Re: [Libhugetlbfs-devel] Buglet in 16G page handling
Message-ID: <20080905013604.GB7845@yookeroo.seuss>
References: <20080902050510.GB12965@yookeroo.seuss>
	<48BD73FB.1050601@linux.vnet.ibm.com>
	<20080903002029.GC9681@yookeroo.seuss>
	<48BF0D6F.2010602@linux.vnet.ibm.com>
	<48C04E4E.6090408@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48C04E4E.6090408@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2008 at 04:08:30PM -0500, Jon Tollefson wrote:
> Jon Tollefson wrote:
> > David Gibson wrote:
> >   
> >> On Tue, Sep 02, 2008 at 12:12:27PM -0500, Jon Tollefson wrote:
[snip]
> > I have run through the tests twice now with this new patch using a 4k
> > base page size(and 16G huge page size) and there are no program checks
> > or spin lock issues.  So looking good.
> >
> > I will run it next a couple of times with 64K base pages.
> >   
> I have run through the libhugetest suite 3 times each now with both
> combinations(4k and 64K base page) and have not seen the spin lock
> problem or any other problems.

Excellent.  I'll push the patch.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
