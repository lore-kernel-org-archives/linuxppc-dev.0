Return-Path: <B45939@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 830DC2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 20:33:57 +1000 (EST)
Message-ID: <521B2EF7.2050805@freescale.com>
Date: Mon, 26 Aug 2013 18:33:27 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v7 2/3] DMA: Freescale: Add new 8-channel DMA engine device
 tree nodes
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-3-git-send-email-hongbo.zhang@freescale.com>
 <521541EE.4010303@wwwdotorg.org>
 <1377126028.5029.52.camel@snotra.buserror.net>
 <52154A34.4020405@wwwdotorg.org> <5216D461.4010604@freescale.com>
In-Reply-To: <5216D461.4010604@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com,
 linux-kernel@vger.kernel.org, djbw@fb.com,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2013 11:17 AM, Hongbo Zhang wrote:
> On 08/22/2013 07:16 AM, Stephen Warren wrote:
>> On 08/21/2013 05:00 PM, Scott Wood wrote:
>>> On Wed, 2013-08-21 at 16:40 -0600, Stephen Warren wrote:
>>>> On 07/29/2013 04:49 AM, hongbo.zhang@freescale.com wrote:
>>>>> +        - reg               : <registers mapping for channel>
>>>>> +        - interrupts        : <interrupt mapping for DMA channel 
>>>>> IRQ>
>>>> s/interrupts/specifier/
>>> Do you mean s/interrupt mapping/interrupt specifier/?
>>>
>>> And probably s/registers mapping/register specifier/ as well.
>> Yup.
>>
> OK, I will update these descriptions.
>
Since Scott has clarified all the doubts, and no further comment till 
now, so my next iteration will include this s/mapping/specifier only.
I will sent it out this Tuesday, if there is still any comment/doubt, 
please let me know.
