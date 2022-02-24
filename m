Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C977C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Feb 2022 15:14:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K4GfN2MdPz3cXG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Feb 2022 02:14:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=lorenzo.pieralisi@arm.com; receiver=<UNKNOWN>)
X-Greylist: delayed 497 seconds by postgrey-1.36 at boromir;
 Fri, 25 Feb 2022 02:14:11 AEDT
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4K4Gdv0rCKz2yQK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Feb 2022 02:14:10 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E753EED1;
 Thu, 24 Feb 2022 07:05:49 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.39.248])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 553923F66F;
 Thu, 24 Feb 2022 07:05:46 -0800 (PST)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, alex@ghiti.fr
Subject: Re: [PATCH v7 05/14] sizes.h: Add SZ_1T macro
Date: Thu, 24 Feb 2022 15:05:39 +0000
Message-Id: <164571512667.19192.1380245684595719481.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <575cb7164cf124c75df7cb9242ea7374733942bf.1642752946.git.christophe.leroy@csgroup.eu>
References: <cover.1642752946.git.christophe.leroy@csgroup.eu>
 <575cb7164cf124c75df7cb9242ea7374733942bf.1642752946.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Toan Le <toan@os.amperecomputing.com>, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 21 Jan 2022 08:42:21 +0000, Christophe Leroy wrote:
> Today drivers/pci/controller/pci-xgene.c defines SZ_1T
> 
> Move it into linux/sizes.h so that it can be re-used elsewhere.
> 
> 

Applied to pci/misc, thanks!

[05/14] sizes.h: Add SZ_1T macro
        https://git.kernel.org/lpieralisi/pci/c/0cc62aed37

Thanks,
Lorenzo
