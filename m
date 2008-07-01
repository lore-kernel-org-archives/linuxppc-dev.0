Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 540D0DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 11:45:17 +1000 (EST)
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18537.34789.355993.604857@cargo.ozlabs.ibm.com>
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
	<18537.34789.355993.604857@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Jul 2008 11:45:10 +1000
Message-Id: <1214876710.20711.69.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-01 at 11:27 +1000, Paul Mackerras wrote:
> Paul Mackerras writes:
> 
> > The following commits have been added to the master and powerpc-next
> > branches of the powerpc.git repository.  This includes patches pulled
> > from Kumar's and Josh's trees.
> 
> Hold off from pulling this for now, everyone...  I inadvertently broke
> builds with 64k pages by leaving in some stuff that was purely for
> testing in my "Only demote individual slices rather than whole
> process" patch.  I'll re-do the tree in order to avoid breaking
> bisection.

Any chance to get my 4xx PTE rework in too ?

Cheers,
Ben.
 
