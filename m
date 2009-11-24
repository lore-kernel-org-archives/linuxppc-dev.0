Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EE58B6F09
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 16:25:55 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAOGPsDU004133
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2009 03:25:54 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAO5Psu11081356
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2009 16:25:54 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAO5Prgk002484
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2009 16:25:54 +1100
Date: Tue, 24 Nov 2009 10:55:43 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 0/4] pseries: Add cede support for cpu-offline
Message-ID: <20091124052543.GA28097@dirshya.in.ibm.com>
References: <20091030052106.25493.42109.stgit@sofia.in.ibm.com>
	<1259033709.16367.110.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1259033709.16367.110.camel@pasglop>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2009-11-24 14:35:09]:

> On Fri, 2009-10-30 at 10:52 +0530, Gautham R Shenoy wrote:
> > Hi,
> > 
> > This is version 5 of patch series that provides a framework to choose the
> > state a pseries CPU must be put to when it is offlined.
> > 
> > Previous versions can be found here:
> > Version 4: http://lkml.org/lkml/2009/10/9/59
> > Version 3: http://lkml.org/lkml/2009/9/15/164
> > Version 2: http://lkml.org/lkml/2009/8/28/102
> > Version 1: http://lkml.org/lkml/2009/8/6/236
> > 
> > Changes from the previous version include:
> > - Rebased against Nathan Fontenot's latest "pseries kernel handling of dynamic
> >   logical paritioning v4" patches found here:
> >   http://lkml.org/lkml/2009/10/21/98
> 
> I can't merge them right now because afaik, Nathan patches are still not
> quite ready. So we need to either get a final version of Nathan patches
> something like tomorrow or you need to rebase your series on current
> -next by the end of the week, or I'm afraid it's going to miss the next
> merge window.

Hi Ben,

I had checked with Nathan earlier and he mentioned that he is working
on an update.  We can post a rebase to -next tomorrow, but this series
depends on Nathan's patch, hence will work with him. This feature is
important for the next merge window.

Thanks,
Vaidy
