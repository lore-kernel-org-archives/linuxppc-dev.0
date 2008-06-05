Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13AD2E02EF
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 05:14:21 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55JEIi1006702
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 15:14:18 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55JEIp1170712
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 15:14:18 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55JEHgv007842
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 15:14:18 -0400
Date: Thu, 5 Jun 2008 14:13:57 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
Message-ID: <20080605141357.0fd1a6b4@zod.rchland.ibm.com>
In-Reply-To: <E6E776A3-C605-4063-B78D-99B06BAA36EA@kernel.crashing.org>
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
	<fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
	<20080605101838.5b1d9233@zod.rchland.ibm.com>
	<E6E776A3-C605-4063-B78D-99B06BAA36EA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 13:59:44 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jun 5, 2008, at 10:18 AM, Josh Boyer wrote:
> 
> > On Thu, 5 Jun 2008 09:11:48 -0600
> > "Grant Likely" <grant.likely@secretlab.ca> wrote:
> >
> >> On Thu, Jun 5, 2008 at 8:52 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com 
> >> > wrote:
> >>> This commit (patch omitted due to size) is sitting in my local tree:
> >>>
> >>> commit 0d7efc1e80fc262bcc507a605482c5681e3f082a
> >>> Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> >>> Date:   Thu Jun 5 09:46:17 2008 -0500
> >>>
> >>>   ppc/4xx: Remove 4xx support from arch/ppc
> >>>
> >>>   Remove support for PPC 403, 405, and 440 processors from arch/ 
> >>> ppc.  The
> >>>   arch/powerpc equivalents should be used.  Boards that are not  
> >>> ported yet
> >>>   will need to be ported to arch/powerpc to have continued support.
> >>
> >> This looks like unneeded churn.
> >
> > Excellent.  My prompting has succeeded.  Though now I won't get to be
> > on top of the "top contributors" list in the lwn.net pages like Kumar
> > was.  Oh well.
> 
> defconfig updates is the secret :)

If only I had as many boards as you! ;)

josh
