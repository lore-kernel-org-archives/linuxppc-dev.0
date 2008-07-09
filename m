Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58A0BDDFC1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 03:25:12 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69HP80O030621
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 13:25:08 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m69HP8e4087010
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 11:25:08 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m69HP7np020884
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 11:25:07 -0600
Date: Wed, 9 Jul 2008 13:21:44 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Updates to powerpc.git
Message-ID: <20080709132144.2443ea48@zod.rchland.ibm.com>
In-Reply-To: <4BD688FB-13AF-4076-BF9A-1F7BEA7E7D65@kernel.crashing.org>
References: <1215588881.8970.358.camel@pasglop>
	<7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
	<20080710020832.3e654bc9.sfr@canb.auug.org.au>
	<20080709162008.GC28130@secretlab.ca>
	<1215621093.32502.1.camel@weaponx>
	<4BD688FB-13AF-4076-BF9A-1F7BEA7E7D65@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Jul 2008 11:47:45 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jul 9, 2008, at 11:31 AM, Josh Boyer wrote:
> 
> > On Wed, 2008-07-09 at 10:20 -0600, Grant Likely wrote:
> >> On Thu, Jul 10, 2008 at 02:08:32AM +1000, Stephen Rothwell wrote:
> >>> Kumar,
> >>>
> >>> On Wed, 9 Jul 2008 07:58:38 -0500 Kumar Gala <galak@kernel.crashing.org 
> >>> > wrote:
> >>>>
> >>>> What is your intent with the 'master' branch?  I hope you do NOT  
> >>>> plan
> >>>> on ever rebasing it.  I assume if a patch gets into master and we  
> >>>> drop
> >>>> it you'll do a git-revert of it?
> >>>
> >>> "Ever" is such a strong word.  Even Paul on occasion rebased his  
> >>> master
> >>> branch.  I see no reason why Ben could not run his master (or maybe
> >>> better named "test") branch as a place that patches come and go  
> >>> and his
> >>> "next" branch as something that never (or very rarely) gets  
> >>> rebased with
> >>> commits progressing from master (test) to next when he is  
> >>> satisfied with
> >>> them. People should then base further work in the "next" branch.
> >>
> >> I was under the impression that there was some consensus that -next
> >> branches should be used for unstable experiments.  Am I mistaken?
> >
> > Yes,  you are.  It's slightly confusing.  -next branches are for  
> > things
> > decidedly going into the "next" release of the kernel.  If they are
> > unstable, they aren't really proven to be ready then.
> 
> Did, GregKH start up a tree for code not quite ready ( -staging).

Yes.  The proliferation of "trees" is getting to be a bit ridiculous.
We have Linus, -next, -mm, -staging, plus all the subsystem variants of
those.

The answer to "What tree do I develop against" _should_ be -next, but
sometimes that isn't the case and finding the answer isn't getting
easier.

josh
