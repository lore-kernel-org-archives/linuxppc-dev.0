Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C79DDE01E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 07:50:07 +1000 (EST)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <DE108B1C-85A6-4D1F-8E4D-E1AB5495578A@kernel.crashing.org>
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<1242622141.18075.37.camel@pasglop>
	<DE108B1C-85A6-4D1F-8E4D-E1AB5495578A@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 19 May 2009 07:49:55 +1000
Message-Id: <1242683395.16901.0.camel@pasglop>
Mime-Version: 1.0
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-05-18 at 08:25 -0500, Kumar Gala wrote:
> 
> Part of this is how the generic swiotlb code works and part of it
> was  
> our desire not to bloat dev archdata by adding such info that as you  
> say is either bus specific or conveyed in the dma addr mask.

Right but perf sucks :-)

Maybe an option is to clamp the DMA mask when it's set by the driver to
limit it to the available inbound window ?

Cheers,
Ben.
