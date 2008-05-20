Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 715BBDDF3D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:53:59 +1000 (EST)
Date: Tue, 20 May 2008 23:15:16 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
Message-ID: <20080520231516.76b924a2@core>
In-Reply-To: <483344C0.3020703@freescale.com>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop>
	<483344C0.3020703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Trent Piepho <tpiepho@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It looks like we rely on -fno-strict-aliasing to prevent reordering 
> ordinary memory accesses (such as to DMA descriptors) past the I/O 

DMA descriptors in main memory are dependant on cache behaviour anyway
and the dma_* operators should be the ones enforcing the needed behaviour.

Alan
