Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89DD8B7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 12:32:35 +1100 (EST)
Subject: Re: [PATCH 3/4] powerpc: Reduce differences between pseries and
	ppc64 defconfigs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1260235641.4668.1.camel@concordia>
References: <20091207034509.GA3421@kryten> <20091207034555.GB3421@kryten>
	<20091207034714.GC3421@kryten>  <1260235641.4668.1.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Dec 2009 12:32:24 +1100
Message-ID: <1260235944.10809.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-08 at 12:27 +1100, Michael Ellerman wrote:
> > The pseries and ppc64 defconfigs have drifted apart over the years.
> Reduce
> > some of the differences while still keeping the idea that the ppc64
> defconfig
> > is cross platform but enables fewer features than pseries, eg:
> > 
> > - NR_CPUS is lower
> > - No NUMA support
> 
> Hmm, most of the modern 64 bit platforms are NUMA aren't they? Just a
> thought. 

Also no NUMA is going to hurt Cell too. I think we should leave that in.

Cheers,
Ben.
