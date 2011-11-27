Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 34B7FB6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 09:40:56 +1100 (EST)
Message-ID: <1322433640.23348.2.camel@pasglop>
Subject: Re: [PATCH] perf events, powerpc: Add POWER7
 stalled-cycles-frontend/backend events
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <michael.neuling@au1.ibm.com>
Date: Mon, 28 Nov 2011 09:40:40 +1100
In-Reply-To: <4880.1315549581@neuling.org>
References: <4E5C6A7D.2010909@linux.vnet.ibm.com>
 <25545.1315532289@neuling.org> <4E69AFCF.3040404@linux.vnet.ibm.com>
 <4880.1315549581@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-09-09 at 16:26 +1000, Michael Neuling wrote:

> I agree, I think they match what Ingo is trying to achieve.
> 
> Can you add these descriptions to the patch and resubmit please?
> 
> If you can find similar events for power4/5/5+/6 that would be great too
> submit too.  
> 
> FWIW, the patch compiles and runs for me.  

I already put it in my next branch, but feel free to send a followup
patch adding some comments if you think that's worthwhile.

Cheers,
Ben.
