Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C577140198
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 15:25:24 +1000 (EST)
Message-ID: <536B1388.2070006@Freescale.com>
Date: Thu, 8 May 2014 00:18:00 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH 5/6] powerpc/corenet: Add DPAA FMan support to the SoC
 device tree(s)
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-5-git-send-email-Shruti@Freescale.com>
 <1398118442.1694.190.camel__272.432543761347$1398129129$gmane$org@snotra.buserror.net>
 <53661DAB.10808@Freescale.com>
 <1399332886.15726.161.camel@snotra.buserror.net>
 <5368811A.3060609@Freescale.com>
 <1399504442.15726.353.camel@snotra.buserror.net>
In-Reply-To: <1399504442.15726.353.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Kanetkar Shruti-B44454 <Shruti@Freescale.com>,
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


On 05/07/2014 06:14 PM, Scott Wood wrote:
> On Tue, 2014-05-06 at 01:28 -0500, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 05/05/2014 06:34 PM, Scott Wood wrote:
>>> On Sun, 2014-05-04 at 05:59 -0500, Emil Medve wrote:
>>>>  Anyway, most days PHYs can be discovered so they don't use/need
>>>> compatible properties. That's I guess part of the reason we don't have
>>>> bindings for them PHY nodes
>>>
>>> I don't see why there couldn't be a compatible that describes the
>>> standard programming interface.
>>
>> Because it can be detected at runtime and I guess stuff like that should
>> stay out of the device tree. I'm using PCI as an analogy here
> 
> But in this case aren't you using a standardized component of the
> programming model itself to probe the specific PHY type?  I think a
> better analogy is the "cfi-flash" compatible.

Well, to speak your language,
Documentation/devicetree/bindings/net/phy.txt claims the 'compatible' to
be optional, case in which at least 'ethernet-phy-ieee802.3-c22' is
implied. 'ethernet-phy-ieee802.3-c22' (1 Gb/s MDIO/PHY) conveys the
standardized programming model that allows probing


Cheers,
