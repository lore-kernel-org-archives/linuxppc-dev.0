Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0070EB7E08
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 19:25:39 +1000 (EST)
Subject: RE: [PATCH] pte_fsl_booke: fix instruction TLB error permission check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Dave-R63238 <r63238@freescale.com>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB12089B975F5@zch01exm21.fsl.freescale.net>
References: <1273221514-8683-1-git-send-email-leoli@freescale.com>
	<0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
	<1273787172.21352.198.camel@pasglop>
	<D7CCA83BB0796C49BC0BB53B6AB12089B97531@zch01exm21.fsl.freescale.net>
	<1273828131.21352.604.camel@pasglop>
	<D7CCA83BB0796C49BC0BB53B6AB12089B975F5@zch01exm21.fsl.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 May 2010 19:25:21 +1000
Message-ID: <1273829121.21352.605.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jin Qing-B24347 <B24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-05-14 at 17:14 +0800, Liu Dave-R63238 wrote:
> > > Aaron pointed the issue on FSL BookE.
> > > 
> > http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-January/079738.htm
> > > l
> > 
> > Right, but I think 64-bit BookE has the same issue. We can 
> > fix that later tho.
> 
> Ben,
> 
> We also find the _PAGE_USER is different between pte-book3e and old
> fsl-booke
> It is UR in old fsl-booke, and is _PAGE_BAP_UR | _PAGE_BAP_SR in
> pte-book3e,
> which will cause the ioremap_flags issue.
> 
> Did you have a test your commit
> [ea3cc330ac0cd521ff07c7cd432a1848c19a7e92]?

I tested on some things :-) I keep asking Kumar to send me some e500
gear so I can actually test on it :-)

Cheers,
Ben.
