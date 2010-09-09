Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 78DDBB6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 12:52:17 +1000 (EST)
Date: Wed, 8 Sep 2010 19:52:14 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909025214.GA21846@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283994156.6515.6.camel@pasglop>
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 11:02:36AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2010-09-08 at 16:21 -0700, Ira W. Snyder wrote:
> > 
> > 
> > I am happy to provide more information if it will help. I'm not
> > especially
> > good at working the debugger. I can't get it to stop at machine_init()
> > and let
> > me step through the code.
> > 
> > I tried this feature when it first became available on powerpc, and it
> > did not work then. At that time, I didn't have the resources to
> > investigate further. I don't think a git bisect will help in this
> > case.
> 
> That's a concern... lockdep_init() is expected to only perform static
> initializations...
> 

Yes, I looked over the function, and I don't understand where it goes
wrong.

> Any chance you can stick a data breakpoint early on to catch when the
> corruption happens ?
> 

I will attempt to get the debugger to stop at start_kernel. I'm having
trouble driving the JTAG debugger (a BDI2000). I have used Denx's guide
[1] in the past, but the section on debugging the kernel itself is now
missing.

[1] http://www.denx.de/wiki/view/DULG/DebuggingLinuxKernel

I'll keep trying.

Thanks for the reply,
Ira
