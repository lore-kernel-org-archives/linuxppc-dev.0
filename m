Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5ABD4B7D54
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 19:35:04 +1000 (EST)
Date: Tue, 27 Apr 2010 18:34:51 +0900
To: benh@kernel.crashing.org
Subject: Re: 2.6.34-rc3 : Badness at lib/dma-debug.c:820 during ibmvscsi init
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1272351921.24542.8.camel@pasglop>
References: <4BB590C6.3090108@in.ibm.com>
	<20100402154959K.fujita.tomonori@lab.ntt.co.jp>
	<1272351921.24542.8.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20100427183609W.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, brking@linux.vnet.ibm.com,
	linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 Apr 2010 17:05:21 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2010-04-02 at 15:50 +0900, FUJITA Tomonori wrote:
> 
> > Thanks, here's the patch in the proper format.
> > 
> > =
> > From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > Subject: [PATCH] ibmvscsi: fix DMA API misuse
> > 
> > ibmvscsi uses dma_unmap_single() for buffers mapped via
> > dma_map_sg(). It works however it's the API violation. The DMA debug
> > facility complains about it:
> 
> Hi folks !
> 
> Is this going to be merged via the scsi tree ?

Already merged (a71fa1fc43a29133f13ae6ada1a389ca298c0934).
