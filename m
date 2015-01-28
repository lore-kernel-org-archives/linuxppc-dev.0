Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0135.outbound.protection.outlook.com [157.56.110.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35C981A0902
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 08:49:18 +1100 (AEDT)
Message-ID: <54C95910.60402@Freescale.com>
Date: Wed, 28 Jan 2015 15:48:00 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Mike Turquette <mturquette@linaro.org>, <linuxppc-dev@lists.ozlabs.org>,
 <scottwood@Freescale.com>, <haokexin@gmail.com>,
 <yuantian.tang@Freescale.com>
Subject: Re: [PATCH v2 00/10] clk: qoriq: Add support for the FMan clock
References: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
 <20150128181504.22722.30981@quantum>
In-Reply-To: <20150128181504.22722.30981@quantum>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mike,


On 01/28/2015 12:15 PM, Mike Turquette wrote:
> Quoting Emil Medve (2015-01-21 02:03:22)
>> Based on clk-next from git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
>>
>> v2:     Rebased as several prerequisite patches (including a file rename) got
>>         applied upstream
>>
>> Emil Medve (9):
>>   clk: qoriq: Fix checkpatch type PARENTHESIS_ALIGNMENT
>>   clk: qoriq: Fix checkpatch type ALLOC_WITH_MULTIPLY
>>   clk: qoriq: Fix checkpatch type ALLOC_SIZEOF_STRUCT
>>   clk: qoriq: Fix checkpatch type OOM_MESSAGE
>>   clk: qoriq: Make local symbol 'static'
>>   clk: qoriq: Replace kzalloc() with kmalloc()
>>   clk: qoriq: Use pr_fmt()
> 
> Patches 1-7 applied to clk-next towards 3.20

Thank you

> I'd prefer some
> reviewed-by's from your peers at freescale for the clock driver
> correctness.

That's fair

>>   powerpc/corenet: Enable CLK_QORIQ

I was thinking Scott can pick this up

>>   clk: qoriq: Add support for the platform PLL

I'll get Yuan-Tian to review this

>> Igal Liberman (1):
>>   clk: qoriq: Add support for the FMan clock

Scott, I'd appreciate your help here


Cheers,


>>  arch/powerpc/configs/corenet32_smp_defconfig |   1 +
>>  arch/powerpc/configs/corenet64_smp_defconfig |   1 +
>>  drivers/clk/clk-qoriq.c                      | 378 +++++++++++++++++++++++++--
>>  3 files changed, 357 insertions(+), 23 deletions(-)
>>
>> -- 
>> 2.2.1
