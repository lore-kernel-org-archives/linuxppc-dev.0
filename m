Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D5FC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 06:30:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B93620821
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 06:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLJtwf7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B93620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lJNr1LkczF3KH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 17:30:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nLJtwf7n";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=shawnguo@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nLJtwf7n"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lJJP3kCNzF3K3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 17:26:29 +1100 (AEDT)
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B73E120821;
 Wed, 31 Oct 2018 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1540967187;
 bh=1iKpm2V2KRA9X4nkVZwPCPgATmLoHX8IaTTqNM8FoGE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nLJtwf7nZaVk/T44iMT6EUOzM9u6Hldocj+CaptsuQmb7JYREBSYLsvFHHpyAZAWP
 D6mwsJBZzWBJpfJ2NpB25JZbLOXWS0Vk3e6z86dSGl1YcpkMTdJZlIY+wSa1D6+y2f
 q2wbwZklhKpfUOEnNuzFCZaAIFFGXRuxrQKqmcSM=
Date: Wed, 31 Oct 2018 14:25:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v7 6/6] arm64: dts: add LX2160ARDB board support
Message-ID: <20181031062555.GD10386@tiger>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
 <1540759926-3641-7-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540759926-3641-7-git-send-email-vabhav.sharma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 Sriram Dash <sriram.dash@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Horia Geanta <horia.geanta@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>,
 Udit Kumar <udit.kumar@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Yinbo Zhu <yinbo.zhu@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "oss@buserror.net" <oss@buserror.net>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Varun Sethi <V.Sethi@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Ying Zhang <ying.zhang22455@nxp.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 Ran Wang <ran.wang_1@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 08:58:01AM +0000, Vabhav Sharma wrote:
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.
> 
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks.
