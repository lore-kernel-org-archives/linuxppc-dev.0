Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77157B7102
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2010 08:11:20 +1000 (EST)
Subject: Re: ppc44x - how do i optimize driver for tlb hits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20100924130851.GA14016@crust.elkhashab.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
	<1285279264.5158.18.camel@pasglop>
	<20100923223516.GA30033@crust.elkhashab.com>
	<1285290444.14081.6.camel@pasglop>
	<20100924025849.GA5619@crust.elkhashab.com>
	<1285303432.14081.28.camel@pasglop>
	<20100924103034.GA27958@zod.rchland.ibm.com>
	<20100924130851.GA14016@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 25 Sep 2010 08:11:04 +1000
Message-ID: <1285366264.14081.33.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-09-24 at 08:08 -0500, Ayman El-Khashab wrote:
> 
> I suppose another option is to to use the kernel profiling option I 
> always see but have never used.  Is that a viable option to figure out
> what is happening here?  

With perf and stochastic sampling ? If you sample fast enough... but
you'll mostly point to your routine I suppose... though it might tell
you statistically where in your code, which -might- help.

Cheers,
Ben.
