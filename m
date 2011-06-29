Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC996B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 08:21:07 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/book3e-64: use a separate TLB handler when
	linear map is bolted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110629144010.1fe5df24@schlenkerla.am.freescale.net>
References: <20110622212542.GA23089@schlenkerla.am.freescale.net>
	<1309333828.14501.65.camel@pasglop>
	<20110629144010.1fe5df24@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Jun 2011 08:20:58 +1000
Message-ID: <1309386058.14501.88.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-29 at 14:40 -0500, Scott Wood wrote:
> What is the "weird page table format" referred to by the normal miss
> handler?

Not sure :-) Probably the fact that we allocate 64K for PTE pages but
only use 32K of them ?

Cheers,
Ben.
