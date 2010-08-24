Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40A7CB70AF
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Aug 2010 15:39:58 +1000 (EST)
Subject: Re: [PATCH] powerpc: remove fpscr use from [kvm_]cvt_{fd,df}
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <32250.1282626925@neuling.org>
References: <m2hbinzlon.fsf@igel.home> <27922.1282523025@neuling.org>
	<1282626718.22370.505.camel@pasglop>  <32250.1282626925@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 15:39:40 +1000
Message-ID: <1282628380.22370.515.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>,
	kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> The way the ifdefs are, it's the other way around.  4xx procs don't need
> to save/restore fpscr and others do.

Hrm, oh well, 601 manual says FPSCR is unaffected too :-)

Cheers,
Ben. 
