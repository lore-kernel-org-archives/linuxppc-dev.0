Return-Path: <SRS0=iKYh=FM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2880C4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 16:56:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EE723B02
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 16:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EE723B02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cr5tr1Ww0zDqhb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 03:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.201;
 helo=relay8-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cr5rn4FXlzDqdp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2020 03:55:02 +1100 (AEDT)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr
 [86.194.74.19]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D70561BF20A;
 Tue,  8 Dec 2020 16:54:48 +0000 (UTC)
Date: Tue, 8 Dec 2020 17:54:48 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 0/5] drop unused BACKLIGHT_GENERIC option
Message-ID: <20201208165448.GN431442@piout.net>
References: <20201201222922.3183-1-andrey.zhizhikin@leica-geosystems.com>
 <160744514229.359082.11487352663734358657.b4-ty@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160744514229.359082.11487352663734358657.b4-ty@arndb.de>
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
List-Id: <soc.lore.kernel.org>
Cc: sam@ravnborg.org, tony@atomide.com, linux-kernel@vger.kernel.org,
 James.Bottomley@hansenpartnership.com, wens@csie.org, thierry.reding@gmail.com,
 paulus@samba.org, will@kernel.org, daniel.thompson@linaro.org, deller@gmx.de,
 linux@armlinux.org.uk, krzk@kernel.org, jonathanh@nvidia.com,
 ludovic.desroches@microchip.com, catalin.marinas@arm.com,
 linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, mripard@kernel.org,
 Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>, soc@kernel.org,
 linux-tegra@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jernej.skrabec@siol.net,
 tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 emil.l.velikov@gmail.com, nicolas.ferre@microchip.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On 08/12/2020 17:34:46+0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On Tue, 1 Dec 2020 22:29:17 +0000, Andrey Zhizhikin wrote:
> > Since the removal of generic_bl driver from the source tree in commit
> > 7ecdea4a0226 ("backlight: generic_bl: Remove this driver as it is
> > unused") BACKLIGHT_GENERIC config option became obsolete as well and
> > therefore subject to clean-up from all configuration files.
> > 
> > This series introduces patches to address this removal, separated by
> > architectures in the kernel tree.
> > 
> > [...]
> 
> While my plan was to only take the arm specific patches, it seems
> nobody else has applied the other architecture specific ones,
> but there have been a lot of Acks. Also, b4 makes it easy to
> merge the entire branch, so I'll just take all of these.
> 
> Applied to arm/defconfig, thanks!
> 
> [1/5] ARM: configs: drop unused BACKLIGHT_GENERIC option
>       commit: 0437141b4e2233ae0109a9584e7a003cd05b0a20
> [2/5] arm64: defconfig: drop unused BACKLIGHT_GENERIC option
>       commit: 717c4c8336486781630893508b3347ae18953fae
> [3/5] MIPS: configs: drop unused BACKLIGHT_GENERIC option
>       commit: 2257682282531de45929c6006152f6e2ee881b42

Thomas did applied this one:
https://lore.kernel.org/linux-arm-kernel/20201204120632.GA10011@alpha.franken.de/

> [4/5] parisc: configs: drop unused BACKLIGHT_GENERIC option
>       commit: 4e9c44b128d3eb5da129e53c7312240f838c2dbf
> [5/5] powerpc/configs: drop unused BACKLIGHT_GENERIC option
>       commit: 4985c506303fb6a41a885d503a6e1f3d3126431d
> 
>        Arnd

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
