Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DB13B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 11:02:52 +1000 (EST)
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <20100908232124.GB30291@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Sep 2010 11:02:36 +1000
Message-ID: <1283994156.6515.6.camel@pasglop>
Mime-Version: 1.0
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-08 at 16:21 -0700, Ira W. Snyder wrote:
> 
> 
> I am happy to provide more information if it will help. I'm not
> especially
> good at working the debugger. I can't get it to stop at machine_init()
> and let
> me step through the code.
> 
> I tried this feature when it first became available on powerpc, and it
> did not work then. At that time, I didn't have the resources to
> investigate further. I don't think a git bisect will help in this
> case.

That's a concern... lockdep_init() is expected to only perform static
initializations...

Any chance you can stick a data breakpoint early on to catch when the
corruption happens ?

Cheers,
Ben.
