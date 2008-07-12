Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 79178DDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 13:35:30 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4118588wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 20:35:29 -0700 (PDT)
Date: Fri, 11 Jul 2008 21:35:26 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Updates to powerpc.git
Message-ID: <20080712033526.GA27903@secretlab.ca>
References: <1215588881.8970.358.camel@pasglop>
	<7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
	<1215833458.7549.139.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215833458.7549.139.camel@pasglop>
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

On Sat, Jul 12, 2008 at 01:30:58PM +1000, Benjamin Herrenschmidt wrote:
> 
> > What is your intent with the 'master' branch?  I hope you do NOT plan  
> > on ever rebasing it.  I assume if a patch gets into master and we drop  
> > it you'll do a git-revert of it?
> 
> I'll try as much as possible. But I'll keep the option open. "next" is
> the one that should never be rebased I'd say.

I'm cool with that.  As long as I've got something stable to commit on
top of.  :-)

g.
