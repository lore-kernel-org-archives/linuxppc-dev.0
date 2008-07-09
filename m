Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id B323BDED65
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 03:30:26 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so785703yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jul 2008 10:30:25 -0700 (PDT)
Date: Wed, 9 Jul 2008 11:30:22 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Updates to powerpc.git
Message-ID: <20080709173022.GE28130@secretlab.ca>
References: <1215588881.8970.358.camel@pasglop>
	<7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
	<20080710020832.3e654bc9.sfr@canb.auug.org.au>
	<20080709162008.GC28130@secretlab.ca>
	<20080710032346.62545256.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080710032346.62545256.sfr@canb.auug.org.au>
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

On Thu, Jul 10, 2008 at 03:23:46AM +1000, Stephen Rothwell wrote:
> Hi Grant,
> 
> On Wed, 9 Jul 2008 10:20:08 -0600 Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> > I was under the impression that there was some consensus that -next
> > branches should be used for unstable experiments.  Am I mistaken?
> 
> Completely.  Anything that will end up in linux-next must be posted,
> reviewed, unit tested and intended for the next merge window.  i.e. you
> must have basically finished with it (except for inter-subsystem merge
> problems and bugs, or course).

Okay, thanks for the correction.

Cheers,
g.
