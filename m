Return-Path: <SRS0=WfQi=GI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79136C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Jan 2021 09:14:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C51225AC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Jan 2021 09:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C51225AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D96Jm0tnYzDqYK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Jan 2021 20:14:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D96G65N3bzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2021 20:12:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=QJ4XIMcN; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4D96G56yGHz9sVw; Tue,  5 Jan 2021 20:12:29 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4D96G46wxFz9sVv;
 Tue,  5 Jan 2021 20:12:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1609837949;
 bh=yIBmNFY7IIvoYm6vloU8xR4+rOYHg+/39Nso3nw/G/Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QJ4XIMcNpUoJzuoLThPU+S4kvNMOQ0JvXD2FvV7JBizappV2V81lztYDSaaWc0wxx
 sO6nyx6xdkOItuNnYiaiTPTFfA9U0pVjjLcpdcXrNwMgyIkmKa+WiW2eC06NgIytj1
 82IZMpTp/X8XdxCWmUSruiSHlTN5O80eA0yTgHnMnMkB8nvzyVNqW3m5XfzHRA/wQb
 QJ99m/4s1CLJUSuRcwV9z5oMq+lW7zDxsVtCu9grXdkmpEgnNN7q/5BbaTs3Q5irMq
 SkYUXf2ksR4jMHHYVR7JsY578JXhi0wrpnY/6w+OqRmyU1DUhNOmCD1MWqeelicQOS
 n7J7OF+aLF9Ng==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: ethernet: fs_enet: Add missing MODULE_LICENSE
In-Reply-To: <X/PRX+RziaU3IJGi@lunn.ch>
References: <20210105022229.54601-1-mpe@ellerman.id.au>
 <X/PRX+RziaU3IJGi@lunn.ch>
Date: Tue, 05 Jan 2021 20:12:21 +1100
Message-ID: <87zh1ng32i.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, kuba@kernel.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrew Lunn <andrew@lunn.ch> writes:
> On Tue, Jan 05, 2021 at 01:22:29PM +1100, Michael Ellerman wrote:
>> Since commit 1d6cd3929360 ("modpost: turn missing MODULE_LICENSE()
>> into error") the ppc32_allmodconfig build fails with:
>> 
>>   ERROR: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/freescale/fs_enet/mii-fec.o
>>   ERROR: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/freescale/fs_enet/mii-bitbang.o
>> 
>> Add the missing MODULE_LICENSEs to fix the build. Both files include a
>> copyright header indicating they are GPL v2.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c | 1 +
>>  drivers/net/ethernet/freescale/fs_enet/mii-fec.c     | 1 +
>>  2 files changed, 2 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
>> index c8e5d889bd81..76ac1a9eab58 100644
>> --- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
>> +++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
>> @@ -223,3 +223,4 @@ static struct platform_driver fs_enet_bb_mdio_driver = {
>>  };
>>  
>>  module_platform_driver(fs_enet_bb_mdio_driver);
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
>> index 8b51ee142fa3..407c330b432f 100644
>> --- a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
>> +++ b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
>> @@ -224,3 +224,4 @@ static struct platform_driver fs_enet_fec_mdio_driver = {
>>  };
>>  
>>  module_platform_driver(fs_enet_fec_mdio_driver);
>> +MODULE_LICENSE("GPL v2");
>
> Hi Michael
>
> The use of "GPL v2" has been deprecated. Please use just "GPL". There
> is a discussion about this here:
>
> https://lore.kernel.org/patchwork/patch/1036331/
>
> https://www.kernel.org/doc/html/latest/process/license-rules.html#id1

Ah sorry, I just grepped for "GPL v2" and saw lots of examples so copied
that. Will post a new version using "GPL".

cheers
