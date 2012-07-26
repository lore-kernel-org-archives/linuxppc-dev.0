Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 063612C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 23:18:23 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix sram_offset parameter type
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <50113A72.4000508@freescale.com>
Date: Thu, 26 Jul 2012 08:18:17 -0500
Message-Id: <1009B0D9-6F05-4BD3-8261-65E25732A304@kernel.crashing.org>
References: <1342693696-29734-1-git-send-email-claudiu.manoil@freescale.com>
 <37C94886-3DA3-4389-8A67-F13035D2CEA6@kernel.crashing.org>
 <50113A72.4000508@freescale.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2012, at 7:39 AM, Claudiu Manoil wrote:

> On 7/19/2012 3:07 PM, Kumar Gala wrote:
>>=20
>> On Jul 19, 2012, at 5:28 AM, Claudiu Manoil wrote:
>>=20
>>> The sram_offset parameter represents a physical address
>>> and should be of type phys_addr_t. As part of this fix,
>>> the extraction of sram_params is being cleaned-up and
>>> fixed.
>>> This patch fixes now the case when the offset value of
>>> 0xfff00000 was being rejected by the driver (returning
>>> -EINVAL), although this is a valid offset value.
>>>=20
>>> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
>>> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
>>> ---
>>> arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h |    4 +-
>>> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   39 =
++++++++++------------------
>>> 2 files changed, 16 insertions(+), 27 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h =
b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
>>> index 60c9c0b..a4ce9b8 100644
>>> --- a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
>>> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
>>> @@ -1,5 +1,5 @@
>>> /*
>>> - * Copyright 2009-2010 Freescale Semiconductor, Inc
>>> + * Copyright 2009-2010 2012 Freescale Semiconductor, Inc
>>=20
>> we normally do 2009-2010, 2012
>>=20
> Hi Kumar,
>=20
> Should I re-spin this patch, with the copyright year formatted per =
your suggestion above?

please do

- k=
