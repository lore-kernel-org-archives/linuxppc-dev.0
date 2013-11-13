Return-Path: <Emilian.Medve@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9029A2C00BD
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 13:37:43 +1100 (EST)
Received: from mail122-db9 (localhost [127.0.0.1])	by
 mail122-db9-R.bigfish.com (Postfix) with ESMTP id 7318D30093E	for
 <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 02:37:39 +0000 (UTC)
Received: from DB9EHSMHS019.bigfish.com (unknown [10.174.16.236])	by
 mail122-db9.bigfish.com (Postfix) with ESMTP id DDF78420067	for
 <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 02:37:36 +0000 (UTC)
Received: from [10.214.83.60] ([10.214.83.60])	by az84smr01.freescale.net
 (8.14.3/8.14.0) with ESMTP id rAD2bY6v007602	for <linuxppc-dev@ozlabs.org>;
 Tue, 12 Nov 2013 19:37:34 -0700
Message-ID: <5282E52B.2040306@Freescale.com>
Date: Tue, 12 Nov 2013 20:34:19 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
 <1384293891.1403.70.camel__45039.5534084693$1384293935$gmane$org@snotra.buserror.net>
 <5282B277.4090300@Freescale.com>
 <1384307175.1403.118.camel__32063.4016803981$1384307228$gmane$org@snotra.buserror.net>
In-Reply-To: <1384307175.1403.118.camel__32063.4016803981$1384307228$gmane$org@snotra.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 11/12/2013 07:46 PM, Scott Wood wrote:
> On Tue, 2013-11-12 at 16:57 -0600, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 11/12/2013 04:04 PM, Scott Wood wrote:
>>> On Mon, 2013-11-11 at 13:25 -0600, Lijun Pan wrote:
>>>> mpc85xx_smp_defconfig and mpc85xx_defconfig already have CONFIG_P1023RDS=y.
>>>> Merge CONFIG_P1023RDB=y and other relevant configurations into mpc85xx_smp_defconfig and mpc85_defconfig.
>>>>
>>>> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
>>>> ---
>>>>  arch/powerpc/configs/85xx/p1023_defconfig  |  188 ----------------------------
>>>>  arch/powerpc/configs/mpc85xx_defconfig     |   18 +++
>>>>  arch/powerpc/configs/mpc85xx_smp_defconfig |   17 +++
>>>>  3 files changed, 35 insertions(+), 188 deletions(-)
>>>>  delete mode 100644 arch/powerpc/configs/85xx/p1023_defconfig
>>>
>>> Are we still going to want to have one defconfig if and when we finally
>>> get datapath support upstream?  That's a lot of code to add to the 85xx
>>> config just for this one chip.
>>
>> Yes. But for mpc85xx_/smp_defconfig the datapath support shouldn't be
>> enabled by default given that just one SoC in that family has the
>> datapath (and we don't plan to put it in another e500v2 based SoC). For
>> regression/automation purposes config fragments should be used
> 
> Is there any way to specify a meta-config for p1023 (or e500v2-dpaa or
> whatever) that says to combine mpc85xx_smp_defconfig with a dpaa
> fragment?

Not aware of it

> Do we have any config fragments in the tree so far?

Nope. However, just to make sure, the fragment was my secondary point
and not necessarily as a candidate for upstreaming. My main point was
that the datapath support should simply not be enabled by default in the
mpc85xx_[smp_]defconfig


Cheers,
