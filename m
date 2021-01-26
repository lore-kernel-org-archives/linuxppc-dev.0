Return-Path: <SRS0=8Wjn=G5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766EBC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Jan 2021 10:58:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5D022581
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Jan 2021 10:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5D022581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DQ3cm4ZTbzDqgV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Jan 2021 21:58:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=lorenzo.pieralisi@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DQ3Z71pfrzDqgV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2021 21:56:13 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1EBD6E;
 Tue, 26 Jan 2021 02:56:10 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.43.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E284B3F66B;
 Tue, 26 Jan 2021 02:56:08 -0800 (PST)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
Date: Tue, 26 Jan 2021 10:55:58 +0000
Message-Id: <161165853056.18662.6546479628438785039.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210120105246.23218-1-michael@walle.cc>
References: <20210120105246.23218-1-michael@walle.cc>
MIME-Version: 1.0
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
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Saravana Kannan <saravanak@google.com>, Roy Zang <roy.zang@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Minghuan Lian <minghuan.Lian@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 20 Jan 2021 11:52:46 +0100, Michael Walle wrote:
> fw_devlink will defer the probe until all suppliers are ready. We can't
> use builtin_platform_driver_probe() because it doesn't retry after probe
> deferral. Convert it to builtin_platform_driver().

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: layerscape: Convert to builtin_platform_driver()
      https://git.kernel.org/lpieralisi/pci/c/538157be1e

Thanks,
Lorenzo
