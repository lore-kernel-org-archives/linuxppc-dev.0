Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 017721A0E44
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 05:17:22 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2407E140297
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 05:17:20 +1000 (AEST)
Message-ID: <1433963830.2477.136.camel@freescale.com>
Subject: Re: question on FSL_EMB perf
From: Scott Wood <scottwood@freescale.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Date: Wed, 10 Jun 2015 14:17:10 -0500
In-Reply-To: <20150610114126.GN19282@twins.programming.kicks-ass.net>
References: <20150610114126.GN19282@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-10 at 13:41 +0200, Peter Zijlstra wrote:
> Hi Mike, Ben,
> 
> I just noticed:
> 
> arch/powerpc/Kconfig:   select HAVE_PERF_EVENTS_NMI if PPC64
> 
> But can't ppc32 have FSL_EMB perf?

Yes, but it doesn't use NMIs.  ppc64 has lazy interrupt disabling 
which functions as a pseudo-NMI.

-Scott
