Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CE11DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2008 19:11:40 +1100 (EST)
Subject: Re: AMCC PPC460EX Canyonlands does not see PCIe end point with
	only non-prefetchable memory (both 2.6.27.7 and -next)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0811280254y428299a4yd92c1c244bd2482@mail.gmail.com>
References: <c384c5ea0811260632n24e8b536v9a4a16833644976c@mail.gmail.com>
	<c384c5ea0811260725x3476fa43o9950123948e99acb@mail.gmail.com>
	<c384c5ea0811261026y73679a16tfa29a33f3e780954@mail.gmail.com>
	<c384c5ea0811280254y428299a4yd92c1c244bd2482@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 19:11:32 +1100
Message-Id: <1228119092.7356.117.camel@pasglop>
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-28 at 11:54 +0100, Leon Woestenberg wrote:
> 
> I found out that re-programming the end point FPGA again *just* after
> *uboot* read it, and before Linux kernel has started, makes the end
> point appear properly.
> 
> Either u-boot leaves the end point in bad state, or the root complex
> reset also requires an end point reset. (or a third option I could not
> think of yet).

I think you are getting a reset yes, maybe your FPGA loses its
programming or something similar ?

> I'll pick this up on ppc and u-boot mailing list with new info,
> especially with the ppc4xx maintainers.
> 
CC me,

Ben.
