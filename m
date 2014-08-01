Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F20631A01AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 11:53:37 +1000 (EST)
Message-ID: <1406858017.32701.1.camel@concordia>
Subject: Re: scheduler crash on Power
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 01 Aug 2014 11:53:37 +1000
In-Reply-To: <20140730072242.GA21516@us.ibm.com>
References: <20140730072242.GA21516@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: bruno@wolff.to, peterz@infrdead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, jwboyer@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-30 at 00:22 -0700, Sukadev Bhattiprolu wrote:
> I am getting this crash on a Powerpc system using 3.16.0-rc7 kernel plus
> some patches related to perf (24x7 counters) that Cody Schafer posted here:
> 
> 	https://lkml.org/lkml/2014/5/27/768
> 
> I don't get the crash on an unpatched kernel though.

You mean you don't get the crash on 3.16-rc7 ?

I find it hard to believe those 24x7 patches are causing this.
 
> I am also attaching the debug messages that Peterz added
> here: https://lkml.org/lkml/2014/7/17/288

I don't see any FAIL messages in your log, so it looks like you're not hitting
the case that patch was looking for?

> Appreciate any debug suggestions.

Reproduce on an unpatched kernel.

cheers
