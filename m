Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3363DDE41
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 09:12:56 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc: dma code cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Remi Machet <rmachet@slac.stanford.edu>
In-Reply-To: <1223417488.17585.46.camel@pcds-ts102.slac.stanford.edu>
References: <1223413504.17585.28.camel@pcds-ts102.slac.stanford.edu>
	<1223414534.8157.63.camel@pasglop>
	<1223417488.17585.46.camel@pcds-ts102.slac.stanford.edu>
Content-Type: text/plain
Date: Wed, 08 Oct 2008 09:12:51 +1100
Message-Id: <1223417571.8157.67.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-07 at 15:11 -0700, Remi Machet wrote:
> This will disappear since I am going to use the vmalloc pool but out of
> curiosity: calling kmap should not result in any virtual memory from the
> kmap pool being used unless the allocated page is in high memory. Do you
> expect many driver to call dma_alloc with GFP_HIGHMEM?

Hard to tell, but they can so ...

Ben.
