Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A390F140154
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 04:14:46 +1000 (EST)
Message-ID: <1398881677.24575.197.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc 32: Provides VIRT_CPU_ACCOUNTING
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Apr 2014 13:14:37 -0500
In-Reply-To: <1398833787.31586.8.camel@pasglop>
References: <20140319215241.236B21A4BDE@localhost.localdomain>
 <1395266717.12479.293.camel@snotra.buserror.net>
 <1398833787.31586.8.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-30 at 14:56 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2014-03-19 at 17:05 -0500, Scott Wood wrote:
> > On Wed, 2014-03-19 at 22:52 +0100, Christophe Leroy wrote:
> > > This patch provides VIRT_CPU_ACCOUTING to PPC32 architecture.
> > > Unlike PPC64, PPC32 doesn't provide the PACA register. Therefore the
> > > implementation is similar to the one done in the IA64 architecture.
> > > It is based on additional information added to the Task Info structure.
> > 
> > PACA isn't a register -- just a convention for how Linux uses a GPR.
> > Maybe it's time to use it on PPC32 as well?
> 
> PACA is actually a data structure and you really really don't want it
> on ppc32 :-) Having a register point to current works, having a register
> point to per-cpu data instead works too (ie, change what we do today),
> but don't introduce a PACA *please* :-)

What is special about 64-bit that warrants doing things differently from
32-bit?

What is the difference between PACA and "per-cpu data", other than the
obscure name?
 
-Scott
