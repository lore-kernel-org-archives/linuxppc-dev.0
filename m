Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 544441A06CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 10:32:15 +1100 (AEDT)
Message-ID: <1445470334.30295.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/ps3: Quieten the build when building ps3
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, geoff@infradead.org
Date: Thu, 22 Oct 2015 10:32:14 +1100
In-Reply-To: <20151021164746.GA8157@gate.crashing.org>
References: <1445230402-18087-1-git-send-email-mpe@ellerman.id.au>
 <20151021164746.GA8157@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-21 at 11:47 -0500, Segher Boessenkool wrote:

> On Mon, Oct 19, 2015 at 03:53:22PM +1100, Michael Ellerman wrote:

> > The boot wrapper uses dd when building for ps3, which annoyingly tells
> > us in great detail what it's doing, eg:
> > 
> >   512+0 records in
> >   512+0 records out
> >   512 bytes (512 B) copied, 0.000802129 s, 638 kB/s
> >   512+0 records in
> >   512+0 records out
> >   512 bytes (512 B) copied, 0.000745101 s, 687 kB/s
> > 
> > Also annoyingly, there is no "quiet" flag to dd, so our only option is
> > to grab all the output from dd, and iff there is an error print it out.
> 
> "status=none", but that's not POSIX it seems.

Ah darn, that probably would have been fine, I think I just missed it because
it's an argument not a flag.

cheers
