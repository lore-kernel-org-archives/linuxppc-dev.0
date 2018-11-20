Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52EFC41536
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 17:33:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B23720685
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 17:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B23720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zt8L6cBDzF3Zw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 04:33:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=lorenzo.pieralisi@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42zt5t1WPQzF3FY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 04:30:50 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D09BD1DC8;
 Tue, 20 Nov 2018 09:30:48 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D836E3F5AF;
 Tue, 20 Nov 2018 09:30:44 -0800 (PST)
Date: Tue, 20 Nov 2018 17:30:34 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bao Xiaowei <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv4 0/3] dts: Add the property of IB and OB
Message-ID: <20181120173021.GA29331@e107981-ln.cambridge.arm.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171110034847.17891-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: mark.rutland@arm.com, madalin.bucur@nxp.com, catalin.marinas@arm.com,
 will.deacon@arm.com, Minghuan.Lian@nxp.com, hongtao.jia@nxp.com,
 shawnguo@kernel.org, sumit.garg@nxp.com, mingkai.hu@nxp.com, kishon@ti.com,
 Yuantian.Tang@nxp.com, pbrobinson@gmail.com, songxiaowei@hisilicon.com,
 devicetree@vger.kernel.org, Zhiqiang.Hou@nxp.com, robh+dt@kernel.org,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, yangbo.lu@nxp.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 10, 2017 at 11:48:44AM +0800, Bao Xiaowei wrote:
> Depend on http://patchwork.ozlabs.org/patch/815382/
> 
> Bao Xiaowei (3):
>   ARMv8: dts: ls1046a: add the property of IB and OB
>   ARMv8: layerscape: add the pcie ep function support
>   ARMv8: pcie: make the DWC EP driver support for layerscape
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
>  drivers/pci/dwc/Kconfig                        |   1 +
>  drivers/pci/dwc/pci-layerscape.c               | 121 +++++++++++++++++++++++--
>  3 files changed, 121 insertions(+), 7 deletions(-)

Can I drop this series from the linux-pci patch queue ? I reckon
it is superseded by:

https://patchwork.ozlabs.org/patch/992928/

but I wanted to make sure that's the case, I really can't follow
the version numbering so I am asking.

Thanks,
Lorenzo
