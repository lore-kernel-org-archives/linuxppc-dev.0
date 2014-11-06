Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0145.outbound.protection.outlook.com [157.56.110.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33ACE1A0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 02:34:21 +1100 (AEDT)
Message-ID: <545B94F5.6040308@Freescale.com>
Date: Thu, 6 Nov 2014 09:34:13 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH 1/3] powerpc/dts: Factorize the clock control node
References: <1413988937-27885-1-git-send-email-Emilian.Medve@Freescale.com>
 <1414538500.23458.125.camel@snotra.buserror.net>
 <54524405.5090509@Freescale.com>
 <1414711297.23458.173.camel@snotra.buserror.net>
In-Reply-To: <1414711297.23458.173.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
Cc: yuantian.tang@Freescale.com, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 10/30/2014 06:21 PM, Scott Wood wrote:
>>> I don't think the mux stuff belongs here, given that clockgen2.dtsi
>>> doesn't have it, and I saw at least one clockgen1 user needing to
>>> supplement this with more muxes.
>>
>> The intent was to put here devices/nodes that are common per chassis
>> from the low to high end. Specific SoC would change/augment this as
>> appropriate. I could have put each node in its own file as we've done
>> elsewhere, but I thought it would be too much
>>
>> Yes, chassis v1 and v2 have differences, but that's not unexpected
> 
> It just strikes me as being an awkward split of where each mux node
> goes.  Is it guaranteed by the chassis that all v1 will have at least
> the first two muxes?

As far as I'm aware we're not building chassis v1 SoC(s) anymore


Cheers,
