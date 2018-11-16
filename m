Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01216C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 02:52:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23066214F1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 02:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgKG51Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23066214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x2pL0T0SzF3C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 13:52:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rgKG51Od";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=shawnguo@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="rgKG51Od"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x2lT4BzMzF3fn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 13:50:12 +1100 (AEDT)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 39F41208E7;
 Fri, 16 Nov 2018 02:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542336609;
 bh=wcje9mRODaARS3pY5DDvUjbhEoCmXhDzSeeuZFDpZ8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rgKG51Od4MtTM1OhNQv2/HkNJqHhvcH9Mt2J2dNNWzQZtR0ISqdmdujchrL186/nz
 lZ2gyc1n36dtDYbcIVcCiiLxKadf1mR6Yh7NIUYPqBVEkLP+1+8fj/Sy5TU0uuAhuh
 iRN6M4U9+xMA2ObBK4DvRw6BR/1Uq4OHNn0aBBLs=
Date: Fri, 16 Nov 2018 10:49:49 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv2 1/6] arm64: dts: Add the status property disable PCIe
Message-ID: <20181116024947.GD5829@dragon>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105084653.26597-1-xiaowei.bao@nxp.com>
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
Cc: mark.rutland@arm.com, roy.zang@nxp.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, niklas.cassel@axis.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 minghuan.Lian@nxp.com, robh+dt@kernel.org, cyrille.pitchen@free-electrons.com,
 linux-arm-kernel@lists.infradead.org, pombredanne@nexb.com,
 bhelgaas@google.com, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 shawn.lin@rock-chips.com, mingkai.hu@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 05, 2018 at 04:46:48PM +0800, Xiaowei Bao wrote:
> From: Bao Xiaowei <xiaowei.bao@nxp.com>
> 
> Add the status property disable the PCIe, the property will be enable
> by bootloader.
> 
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>

Changed prefix to 'arm64: dts: fsl: ...' and applied the patch.

Shawn
