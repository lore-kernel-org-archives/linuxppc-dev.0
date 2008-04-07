Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84E3DDDEE4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 09:51:44 +1000 (EST)
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080407162053.GB2688@loki.buserror.net>
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
	<18425.24938.332852.315571@cargo.ozlabs.ibm.com>
	<279F1861-9605-46FD-A917-DF5B95B8C4F6@kernel.crashing.org>
	<20080407162053.GB2688@loki.buserror.net>
Content-Type: text/plain
Date: Tue, 08 Apr 2008 09:51:32 +1000
Message-Id: <1207612292.10388.494.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	hollisb@us.ibm.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-07 at 11:20 -0500, Scott Wood wrote:
> 
> Another possible use is a BAT/TLB1 mapping for SoC registers (or
> anything
> else on the board which is frequently accessed), which can be reused
> by
> ioremap() to avoid wasting normal TLB entries, and to facilitate early
> debugging.

As far as the above is concerned, I'm not too fan of fixed virtual
addresses. I'd rather dynamically assign it. But we can do it.

Ben.
