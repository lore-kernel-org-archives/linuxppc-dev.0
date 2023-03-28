Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370F2C6FD1D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Mar 2023 01:18:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PlsJn2VMvz3fXw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Mar 2023 12:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PlsJB70dkz3cDF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2023 12:18:17 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D48968AA6; Tue, 28 Mar 2023 03:18:12 +0200 (CEST)
Date: Tue, 28 Mar 2023 03:18:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v3 0/4] Use dma_default_coherent for devicetree default
 coherency
Message-ID: <20230328011812.GA21977@lst.de>
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com> <20230323072944.GA18524@lst.de> <60D7FE31-D708-4495-949F-3F64DDC11377@flygoat.com> <20230323213930.GA7730@lst.de> <CB41D3AF-20F6-42F3-9168-C0D6E716431A@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CB41D3AF-20F6-42F3-9168-C0D6E716431A@flygoat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, palmer@dabbelt.com, paul.walmsley@sifive.com, Robin Murphy <robin.murphy@arm.com>, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 24, 2023 at 09:17:38AM +0000, Jiaxun Yang wrote:
> > 
> > Is patch a 6.3 candidate or should all of it go into 6.4?
> 
> Please leave it for 6.4, as corresponding MIPS arch part will be a part of 6.4.

Ok.  I'll really need review from the MIPS and drivers/of/ maintainers,
through.
