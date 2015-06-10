Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B4491A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 21:41:35 +1000 (AEST)
Date: Wed, 10 Jun 2015 13:41:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: question on FSL_EMB perf
Message-ID: <20150610114126.GN19282@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mike, Ben,

I just noticed:

arch/powerpc/Kconfig:   select HAVE_PERF_EVENTS_NMI if PPC64

But can't ppc32 have FSL_EMB perf?
