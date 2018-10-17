Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4845C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 07:48:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA8A214C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 07:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA8A214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43QMQq34WhzDqMK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 18:48:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43QMNf6dMVzDqLr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 18:46:42 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9H9Aheb019037;
 Wed, 17 Oct 2018 04:10:44 -0500
Message-ID: <33a2232671caa008541f8de542f8e7a27ab88248.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/8] powerpc: remove CONFIG_PCI_QSPAN
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, Masahiro Yamada
 <yamada.masahiro@socionext.com>
Date: Wed, 17 Oct 2018 20:10:42 +1100
In-Reply-To: <20181017080201.10866-3-hch@lst.de>
References: <20181017080201.10866-1-hch@lst.de>
 <20181017080201.10866-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Alexandre Bounine <alex.bou9@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-17 at 10:01 +0200, Christoph Hellwig wrote:
> This option isn't actually used anywhere.

Oh my, that's ancient. Probably didn't make the cut from arch/ppc to
arch/powerpc

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a80669209155..e8c8970248bc 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -955,7 +955,6 @@ config PCI
>  	bool "PCI support" if PPC_PCI_CHOICE
>  	default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
>  		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
> -	default PCI_QSPAN if PPC_8xx
>  	select GENERIC_PCI_IOMAP
>  	help
>  	  Find out whether your system includes a PCI bus. PCI is the name of
> @@ -969,14 +968,6 @@ config PCI_DOMAINS
>  config PCI_SYSCALL
>  	def_bool PCI
>  
> -config PCI_QSPAN
> -	bool "QSpan PCI"
> -	depends on PPC_8xx
> -	select PPC_I8259
> -	help
> -	  Say Y here if you have a system based on a Motorola 8xx-series
> -	  embedded processor with a QSPAN PCI interface, otherwise say N.
> -
>  config PCI_8260
>  	bool
>  	depends on PCI && 8260

