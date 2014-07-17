Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F085C1A02E7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 21:11:51 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D76A1400B6
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 21:11:50 +1000 (EST)
Message-ID: <1405595380.25310.21.camel@pasglop>
Subject: Re: [PATCH V3 0/3] Add new PowerPC specific ELF core notes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 17 Jul 2014 21:09:40 +1000
In-Reply-To: <53C7A4FA.4030600@linux.vnet.ibm.com>
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
 <53996E41.4070309@linux.vnet.ibm.com> <53C7A4FA.4030600@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
 dhowells@redhat.com, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
 davej@redhat.com, akpm@linux-foundation.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >
> >> Outstanding Issues
> >> ==================
> >> (1) Running DSCR register value inside a transaction does not seem to be saved
> >>     at thread.dscr when the process stops for ptrace examination.
> > 
> > Hey Ben,
> > 
> > Any updates on this patch series ?
> 
> Ben,
> 
> Any updates on this patch series ?

I haven't had a chance to review yet, I was hoping somebody else would..

Have you made any progress vs. the DSCR outstanding issue mentioned
above ?

Cheers,
Ben.
