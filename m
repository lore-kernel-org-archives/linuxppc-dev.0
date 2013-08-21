Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F22BF2C0106
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 09:16:08 +1000 (EST)
Message-ID: <52154A34.4020405@wwwdotorg.org>
Date: Wed, 21 Aug 2013 17:16:04 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v7 2/3] DMA: Freescale: Add new 8-channel DMA engine device
 tree nodes
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-3-git-send-email-hongbo.zhang@freescale.com>
 <521541EE.4010303@wwwdotorg.org>
 <1377126028.5029.52.camel@snotra.buserror.net>
In-Reply-To: <1377126028.5029.52.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8
Cc: devicetree@vger.kernel.org, hongbo.zhang@freescale.com,
 linux-kernel@vger.kernel.org, vinod.koul@intel.com, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2013 05:00 PM, Scott Wood wrote:
> On Wed, 2013-08-21 at 16:40 -0600, Stephen Warren wrote:
>> On 07/29/2013 04:49 AM, hongbo.zhang@freescale.com wrote:
>>> +        - reg               : <registers mapping for channel>
>>> +        - interrupts        : <interrupt mapping for DMA channel IRQ>
>>
>> s/interrupts/specifier/
> 
> Do you mean s/interrupt mapping/interrupt specifier/?
> 
> And probably s/registers mapping/register specifier/ as well.

Yup.
