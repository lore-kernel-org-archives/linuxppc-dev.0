Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id A81D6DE38E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 02:20:12 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so771614yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jul 2008 09:20:11 -0700 (PDT)
Date: Wed, 9 Jul 2008 10:20:08 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Updates to powerpc.git
Message-ID: <20080709162008.GC28130@secretlab.ca>
References: <1215588881.8970.358.camel@pasglop>
	<7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
	<20080710020832.3e654bc9.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080710020832.3e654bc9.sfr@canb.auug.org.au>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2008 at 02:08:32AM +1000, Stephen Rothwell wrote:
> Kumar,
> 
> On Wed, 9 Jul 2008 07:58:38 -0500 Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > What is your intent with the 'master' branch?  I hope you do NOT plan  
> > on ever rebasing it.  I assume if a patch gets into master and we drop  
> > it you'll do a git-revert of it?
> 
> "Ever" is such a strong word.  Even Paul on occasion rebased his master
> branch.  I see no reason why Ben could not run his master (or maybe
> better named "test") branch as a place that patches come and go and his
> "next" branch as something that never (or very rarely) gets rebased with
> commits progressing from master (test) to next when he is satisfied with
> them. People should then base further work in the "next" branch.

I was under the impression that there was some consensus that -next
branches should be used for unstable experiments.  Am I mistaken?

g.
