Return-Path: <srs0=lvwd=4e=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDksn3wmmzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 16:48:13 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDksn37N8z8sv9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 16:48:13 +1000 (AEST)
Message-ID: <1493362089.25766.300.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/xive: Fix/improve verbose debug output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Fri, 28 Apr 2017 08:48:09 +0200
In-Reply-To: <874lx99h25.fsf@concordia.ellerman.id.au>
References: <1493301446.25766.276.camel@kernel.crashing.org>
 <87zif1p6vw.fsf@concordia.ellerman.id.au>
 <1493356805.25766.296.camel@kernel.crashing.org>
 <874lx99h25.fsf@concordia.ellerman.id.au>
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

On Fri, 2017-04-28 at 16:34 +1000, Michael Ellerman wrote:
> > > If there's non-verbose debug that we think would be useful to
> > > differentiate from verbose then those could be pr_debug() - which means
> > > they'll be jump labelled off in most production kernels, but still able
> > > to be enabled.
> > 
> > Maybe... I don't like the giant "debug" switch accross the whole
> > kernel, though.
> 
> Not sure what you mean. You can enable pr_debug()s individually, by
> function, by module, by file, or for the whole kernel.
> 
> To enable everything in xive you'd do:
> 
> # echo 'file *xive* +p' > /sys/kernel/debug/dynamic_debug/control
> 
> Or boot with: loglevel=8 dyndbg="file *xive* +p"

Ah that's new goodness I wasn't aware of. Anyway, I can spin that
later, not planning on doing any work today ;-)

Cheers,
Ben.
