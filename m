Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8E961A0628
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jul 2014 18:26:13 +1000 (EST)
Message-ID: <53D36429.4020106@Freescale.com>
Date: Sat, 26 Jul 2014 03:17:45 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>, Xie Shaohui-B21989
 <Shaohui.Xie@Freescale.com>
Subject: Re: [PATCH v2 1/7] dt: Introduce the FMan 10 Gb/s MDIO binding
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <df68a97dc8ae427f95078082ad587543@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1406318092.29414.116.camel@snotra.buserror.net>
In-Reply-To: <1406318092.29414.116.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Kanetkar Shruti-B44454 <Shruti@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 07/25/2014 02:54 PM, Scott Wood wrote:
> On Thu, 2014-07-24 at 22:11 -0500, Xie Shaohui-B21989 wrote:
>> Hello, Scott, Shruti,
>>
>> There are two types MDIO controllers, each MAC has a corresponding MDIO
>> controller to access internal PHYs inside Serdes, another is dedicated
>> MDIO controller to access external PHYs (PHYs on board or riser card,
>> etc). Current MDIO driver does not distinguish the two controllers, if
>> we need to distinguish the controllers, what could be the proper way?
>> Perhaps a new property is needed in dts?
> 
> Are these different programming models, or just two instances of the
> same type of device, with different things attached?

The controllers are very similar; the FMan v3 MDIO controller is a newer
revision of the FMan v2 10 Gb/s MDIO controller


Cheers,


> -Scott
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
