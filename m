Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B315C3DA6E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Dec 2023 06:27:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T0z8R6gvrz3c1T
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Dec 2023 17:27:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T0z7x4J2Mz30YS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Dec 2023 17:27:25 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C325868C4E; Thu, 28 Dec 2023 07:19:05 +0100 (CET)
Date: Thu, 28 Dec 2023 07:19:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 01/14] arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <20231228061904.GA12475@lst.de>
References: <20231228014220.3562640-1-samuel.holland@sifive.com> <20231228014220.3562640-2-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228014220.3562640-2-samuel.holland@sifive.com>
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
Cc: linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thanks for all the great documentation!

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

