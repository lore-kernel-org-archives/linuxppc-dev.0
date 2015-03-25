Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D4D11A11BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:42:52 +1100 (AEDT)
Message-ID: <1427276571.31588.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: Remove powernv RTAS support
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Wed, 25 Mar 2015 20:42:51 +1100
In-Reply-To: <m3mw317hod.fsf@oc8180480414.ibm.com>
References: <1426141631-10741-1-git-send-email-mpe@ellerman.id.au>
 <m3mw317hod.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-25 at 16:46 +1100, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > The powernv code has some conditional support for running on bare metal
> > machines that have no OPAL firmware, but provide RTAS.
> >
> > No released machines ever supported that, and even in the lab it was
> > just a transitional hack in the days when OPAL was still being
> > developed.
> >
> > So remove the code.
> >
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> The only current place I could think this could be remotely possible
> would be in simulator... and we should instead make the OPAL calls work
> properly in the simulator for all the RTAS functionality (that we care
> about).

If you mean mambo, I tested that, at least the public version, and it doesn't
provide or need RTAS.

On the other sims we ran without RTAS during the Power8 bringup, though it was
eventually used a little bit late in the cycle. In future we should be using
skiboot, or just putting logic directly into the kernel for early bringup - or
permanently :)

> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Thanks.

cheers
