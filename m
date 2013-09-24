Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1640C2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 03:31:27 +1000 (EST)
Message-ID: <5241CC60.5070204@wwwdotorg.org>
Date: Tue, 24 Sep 2013 11:31:12 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Hongbo Zhang <hongbo.zhang@freescale.com>
Subject: Re: [PATCH v10 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
References: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
 <1379499333-4745-3-git-send-email-hongbo.zhang@freescale.com>
 <524074A7.7000001@wwwdotorg.org> <524169E3.7030408@freescale.com>
In-Reply-To: <524169E3.7030408@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ian.campbell@citrix.com,
 pawel.moll@arm.com, vinod.koul@intel.com, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, djbw@fb.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/24/2013 04:30 AM, Hongbo Zhang wrote:
> On 09/24/2013 01:04 AM, Stephen Warren wrote:
>> On 09/18/2013 04:15 AM, hongbo.zhang@freescale.com wrote:
>>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>>
>>> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this
>>> patch adds
>>> the device tree nodes for them.
>>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
>>> b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
>>> +Required properties:
>>> +
>>> +- compatible        : must include "fsl,elo3-dma"
>>> +- reg               : DMA General Status Registers, i.e. DGSR0 which
>>> contains
>>> +                      status for channel 1~4, and DGSR1 for channel 5~8
>> Is that a single entry, which is large enough to cover both registers,
>> or a pair of entries, one per register? Reading the text, I might assume
>> the former, but looking at the examples, it's the latter.
> My impression is that I cannot tell it is one larger entry or two
> entries by reading the description text, but the example gives the answer.
> Is it so important to specify it is only one entry or entries list?
> I prefer language as concise as possible, especially for the common
> properties such as reg and interrupt (eg the reg is implicitly offset
> and length of registers, can be continuous or not), it is difficult or
> unnecessary or impossible to describe much details, the example can also
> work as a complementary description, otherwise no need to put an example
> in the binding document.

The description of the properties should fully describe them. The
example is just an example, not a specification of the properties.
