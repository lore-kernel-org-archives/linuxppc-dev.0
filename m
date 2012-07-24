Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 91BB42C007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 13:22:17 +1000 (EST)
Message-ID: <1343100106.3715.2.camel@pasglop>
Subject: Re: next/mmotm unbootable on G5: irqdomain
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Jul 2012 13:21:46 +1000
In-Reply-To: <CACxGe6udruWL7oo6Qp6jkwQYceduTO1h1gKFz9TFX1TPZoNFNQ@mail.gmail.com>
References: <alpine.LSU.2.00.1207211911160.1585@eggly.anvils>
 <1343011543.2957.2.camel@pasglop>
 <CACxGe6uFvtro7iR8FewgChLr_6PnZA-EaRMKQjrFEaEHg7SKRQ@mail.gmail.com>
 <1343082371.2957.39.camel@pasglop>
 <CACxGe6uo8jx3GQFQpQ5RTHF5JyN2hEgvcvdmSYfGyTQnzK9fOA@mail.gmail.com>
 <CACxGe6udruWL7oo6Qp6jkwQYceduTO1h1gKFz9TFX1TPZoNFNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Paul Mundt <lethal@linux-sh.org>, Rob Herring <rob.herring@calxeda.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 16:32 -0600, Grant Likely wrote:
> > As-is I'm backing off from the linear/legacy/tree merge patch as just
> > too risky. I've already pulled that stuff out of linux-next.
> 
> Can I pull you pseries fix into my tree (my preference), or do I need
> to rebase on top of yours? 

The mpic fix for the g5 is in Linus tree already, I added it on top of
powerpc -next before I asked Linus to pull.

For pseries (ie the fix for irq_find_mapping vs. radix), I don't have a
formal patch, just the one I hand typed in my previous email, so do
whatever you want with it.

Cheers,
Ben.
