Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC4E3DED3D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 06:47:29 +1000 (EST)
To: timur@freescale.com
In-Reply-To: <4807AB7A.90005@freescale.com>
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192846.GB28286@polina.dev.rtsoft.ru>
Message-Id: <E1Jmb0q-0003Si-2M@xyzzy.farnsworth.org>
From: Dale Farnsworth <dale@farnsworth.org>
Date: Thu, 17 Apr 2008 13:47:20 -0700
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > +int qe_usb_clock_set(enum qe_clock clk, int rate)
> > +{
> > +	struct qe_mux __iomem *mux = &qe_immr->qmx;
> > +	unsigned long flags;
> > +	const bool is_brg = clk < QE_CLK1;
> 
> You don't really need "is_brg", since it's only used once.

I find "is_brg" much more meaningful than "clk < QE_CLK1".

Maybe the computer doesn't need it, but it's helpful to a
reader of the code.

-Dale
