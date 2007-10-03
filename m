Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED55FDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 00:22:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l93EMHXC009277
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 10:22:17 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l93EM6a4381868
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 08:22:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l93EM6NL026989
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 08:22:06 -0600
Subject: Re: [PATCH] Use 1TB segments
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18179.2249.445607.10676@cargo.ozlabs.ibm.com>
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
	<1191350274.18159.279.camel@farscape.rchland.ibm.com>
	<18179.2249.445607.10676@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 03 Oct 2007 09:22:01 -0500
Message-Id: <1191421321.18159.302.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-03 at 13:13 +1000, Paul Mackerras wrote:
> Will Schmidt writes:
> 
> > I still need to test this code for performance issues, and this version
> > could still use some cosmetic touchups, so I dont think we want this to
> > go into a tree yet.  I am reposting this primarily to indicate the prior
> > version isnt quite right, and so Jon can rebase to this version.  :-)
> 
> The way we scan the ibm,processor-segment-sizes property could be
> nicer.  Where there any other cosmetic touchups you were thinking of,
> and if so what were they?  I didn't notice any leftover debugging
> printks or anything else that obviously needed cleaning up.

Correct..  nothing in the patch really *needs* to be cleaned up.  This
is mostly me being way more nit-picky than I need to be.  :-)   I don't
have any real issues with the patch (being candidate for) going into a
tree. 

The only obvious is the MMU_SEGSIZE_* #define's in mmu-hash64.h appear
to be duplicated.

The rest I can follow up on later, none of it affects the code outside
of #ifdef DEBUG's and it should be a separate patch anyway.   

Thanks,
-Will

> Paul.
