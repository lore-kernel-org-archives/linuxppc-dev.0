Return-Path: <srs0=7o+t=aw=russell.cc=ruscur@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyL150dnJzDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 12:20:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xyL15012fz8vpj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 12:20:09 +1000 (AEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xyL140R2yz9sNc
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2017 12:20:06 +1000 (AEST)
Message-ID: <1505960399.19485.0.camel@russell.cc>
Subject: Re: [PATCH 1/2] powerpc/eeh: Create PHB PEs after EEH is initialized
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Date: Thu, 21 Sep 2017 12:19:59 +1000
In-Reply-To: <87h8vxljpf.fsf@concordia.ellerman.id.au>
References: <1504766140.12628.14.camel@kernel.crashing.org>
 <87h8vxljpf.fsf@concordia.ellerman.id.au>
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

On Wed, 2017-09-20 at 20:59 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Otherwise we end up not yet having computed the right
> > diag data size on powernv where EEH initialization
> > is delayed, thus causing memory corruption later on
> > when calling OPAL.
> 
> When did this break? Do we have a commit we can tag with Fixes: ?
> Stable?
> 
> I assume we want to merge this ASAP as a fix, I think I can safely take
> this without patch 2?
> 
> cheers

Yes it should be merged ASAP as a fix, and fixes
5cb1f8fdddb7475f38ea9fba48da17c002eec90b.
