Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0125.outbound.protection.outlook.com [207.46.100.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C9DE1A0CE5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 17:25:49 +1100 (AEDT)
Message-ID: <54BF462D.6030304@Freescale.com>
Date: Wed, 21 Jan 2015 00:24:45 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Tang Yuantian-B29983 <Yuantian.Tang@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Wood
 Scott-B07421" <scottwood@Freescale.com>, "mturquette@linaro.org"
 <mturquette@linaro.org>, "haokexin@gmail.com" <haokexin@gmail.com>
Subject: Re: [PATCH 0/8] clk: ppc-corenet: Add support for the platform PLL
References: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
 <BY2PR03MB570918E5F02FF4A86344FDFFA480@BY2PR03MB570.namprd03.prod.outlook.com>
In-Reply-To: <BY2PR03MB570918E5F02FF4A86344FDFFA480@BY2PR03MB570.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Yuan-Tian,


On 01/20/2015 07:40 PM, Tang Yuantian-B29983 wrote:
> Hi Emil,
> 
> Thanks for fixing those warnings. The patch set you based on is merged.
> I sent another two patches and one of them got merged. You probably need to rebase your patches.
> My patch link:
> http://patchwork.ozlabs.org/patch/429257/

I'll rebase on top of this and resubmit


Cheers,


> http://patchwork.ozlabs.org/patch/429258/
> 
> Thanks,
> Yuantian
> 
>> -----Original Message-----
>> From: Emil Medve [mailto:Emilian.Medve@Freescale.com]
>> Sent: Tuesday, January 20, 2015 6:09 PM
>> To: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; mturquette@linaro.org;
>> haokexin@gmail.com; Tang Yuantian-B29983
>> Cc: Medve Emilian-EMMEDVE1
>> Subject: [PATCH 0/8] clk: ppc-corenet: Add support for the platform PLL
>>
>> These patches are based on:
>>
>> http://patchwork.ozlabs.org/patch/417297
>> http://patchwork.ozlabs.org/patch/417295
>> http://patchwork.ozlabs.org/patch/417292
>>
>> The first 5 patches below are checkpatch/static analysis fixes
>>
>> Emil Medve (8):
>>   clk: ppc-corenet: Fix checkpatch type PARENTHESIS_ALIGNMENT
>>   clk: ppc-corenet: Fix checkpatch type ALLOC_WITH_MULTIPLY
>>   clk: ppc-corenet: Fix checkpatch type ALLOC_SIZEOF_STRUCT
>>   clk: ppc-corenet: Fix checkpatch type OOM_MESSAGE
>>   clk: ppc-corenet: Make local symbol 'static'
>>   clk: ppc-corenet: Replace kzalloc() with kmalloc()
>>   powerpc/corenet: Enable CLK_PPC_CORENET
>>   clk: ppc-corenet: Add support for the platform PLL
>>
>>  arch/powerpc/configs/corenet32_smp_defconfig |   1 +
>>  arch/powerpc/configs/corenet64_smp_defconfig |   1 +
>>  drivers/clk/clk-ppc-corenet.c                | 120
>> ++++++++++++++++++++++-----
>>  3 files changed, 101 insertions(+), 21 deletions(-)
>>
>> --
>> 2.2.2
