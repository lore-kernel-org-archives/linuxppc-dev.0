Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF8C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:23:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CBF21D81
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CBF21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bmm4W1kl4zDqN7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 01:23:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjkR3mlrzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:37:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjkP4f7pz9sV5; Wed,  9 Sep 2020 23:37:33 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: alexandre.belloni@bootlin.com, robh+dt@kernel.org, a.zummo@towertech.it,
 mpe@ellerman.id.au, leoyang.li@nxp.com, benh@kernel.crashing.org,
 Biwen Li <biwen.li@oss.nxp.com>
In-Reply-To: <20200527034228.23793-1-biwen.li@oss.nxp.com>
References: <20200527034228.23793-1-biwen.li@oss.nxp.com>
Subject: Re: [v3 1/2] dts: ppc: t4240rdb: remove interrupts property
Message-Id: <159965824243.811679.11439322992907877530.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:37:33 +1000 (AEST)
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
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Biwen Li <biwen.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 27 May 2020 11:42:27 +0800, Biwen Li wrote:
> Since the interrupt pin for RTC DS1374 is not connected
> to the CPU on T4240RDB, remove the interrupt property
> from the device tree.
> 
> This also fix the following warning for hwclock.util-linux:
> $ hwclock.util-linux
> hwclock.util-linux: select() to /dev/rtc0
> to wait for clock tick timed out

Applied to powerpc/next.

[1/2] powerpc/dts/t4240rdb: remove interrupts property
      https://git.kernel.org/powerpc/c/8c7614d648037b0776e0b76cb62911be3b059ea4
[2/2] powerc/dtc/t1024rdb: remove interrupts property
      https://git.kernel.org/powerpc/c/843dc8ee23d1b353fa9cc24da3e52be0111d5931

cheers
