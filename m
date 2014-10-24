Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 106FB1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 20:28:37 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0135.outbound.protection.outlook.com [157.56.111.135])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BB51140081
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2014 20:28:35 +1100 (AEDT)
Message-ID: <544A1B4D.3050904@Freescale.com>
Date: Fri, 24 Oct 2014 04:26:37 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
 portal(s)
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <1413986972-621-2-git-send-email-Emilian.Medve@Freescale.com>
 <20141022142931.GA4010@leverpostej> <54480DE6.4090604@Freescale.com>
 <20141023111622.GB13690@leverpostej>
In-Reply-To: <20141023111622.GB13690@leverpostej>
Content-Type: text/plain; charset="windows-1252"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "Geoff.Thorpe@freescale.com" <Geoff.Thorpe@Freescale.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "scottwood@freescale.com" <scottwood@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mark,


On 10/23/2014 06:16 AM, Mark Rutland wrote:
>>>> +NOTE:	The bindings described in this document are preliminary and subject to
>>>> +	change
>>>
>>> While we've tried that elsewhere, unstable DT bindings have been shown
>>> to be a major source of pain.
>>
>> Agreed
>>
>>> I'd feel rather uncomfortable accepting a
>>> binding that we already believe to be insufficient to describe the
>>> hardware.
>>>
>>> What do you expect to change?
>>
>> Related bindings seem incomplete. As such, the PAMU binding (pamu.txt)
>> covers incompletely a dynamic LIODN assignment/programming model. The
>> current driver uses a static assignment scheme that the binding needs to
>> include. I also suspect that once the driver starts supporting the
>> dynamic LIODN assignment/programming we might find some wrinkles
> 
> Ok. Given that the driver doesn't seem to be in mainline (per a quick
> grep), just put "DO NOT MERGE" or something like that in the commit
> message. Once this is merged you're going to need to support it.

We have a driver and once the bindings get accepted we'll (update the
driver as needed and) post the code


Cheers,
