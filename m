Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A5551A0063
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jan 2015 20:45:29 +1100 (AEDT)
Message-ID: <54AA595C.9090909@Freescale.com>
Date: Mon, 5 Jan 2015 03:29:00 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Xie Shaohui-B21989 <Shaohui.Xie@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Wood
 Scott-B07421" <scottwood@Freescale.com>
Subject: Re: [PATCH 2/2] powerpc/config: enable mdio buses muxing via
 Memory-mapped device
References: <1419240062-29559-1-git-send-email-shh.xie@gmail.com>
 <54A65A09.6070705@Freescale.com>
 <DM2PR0301MB0864469C4DF54A6592E7AA51E25B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
In-Reply-To: <DM2PR0301MB0864469C4DF54A6592E7AA51E25B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Cc: Andy Fleming <afleming@gmail.com>,
 Kanetkar Shruti-B44454 <Shruti@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Shao-Hui,


On 01/03/2015 10:58 PM, Xie Shaohui-B21989 wrote:
> Hello Emil,
> 
> The patches sent by Shruti were marked as "Changes Requested" over 5 months.
> to me if the patches do need changes, the possible changes seems not in 'config' but in corenet_generic.c.

It was part of a series that needed changes in other patches

> I'm not sure if it's OK to add some compatibles in corenet_generic.c. if we can use the existing compatible "simple-bus",
> Then we will only need to enable MDIO mux option in config without adding compatible in corenet_generic.c.

The container "bus" of the "muxing" nodes doesn't carry the "simple-bus"
compatible and (as per the ePAPR definition) I'm unsure it would be
applicable


Cheers,


> Best Regards, 
> Shaohui Xie
> 
>> -----Original Message-----
>> From: Emil Medve [mailto:Emilian.Medve@Freescale.com]
>> Sent: Friday, January 02, 2015 4:43 PM
>> To: shh.xie@gmail.com; linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421
>> Cc: Andy Fleming; Xie Shaohui-B21989; Kanetkar Shruti-B44454
>> Subject: Re: [PATCH 2/2] powerpc/config: enable mdio buses muxing via
>> Memory-mapped device
>>
>> Hello Shao-Hui,
>>
>>
>> On 12/22/2014 03:21 AM, shh.xie@gmail.com wrote:
>>> From: Andy Fleming <afleming@gmail.com>
>>>
>>> Signed-off-by: Andy Fleming <afleming@gmail.com>
>>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>> ---
>>>  arch/powerpc/configs/corenet32_smp_defconfig | 1 +
>>> arch/powerpc/configs/corenet64_smp_defconfig | 1 +
>>>  2 files changed, 2 insertions(+)
>>
>> Shruti submitted a more complete version of this patch here:
>>
>> http://patchwork.ozlabs.org/patch/370873
>>
>> We should stick with that version
>>
>>
>> Cheers,
