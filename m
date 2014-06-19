Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-we0-x235.google.com (mail-we0-x235.google.com
 [IPv6:2a00:1450:400c:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE23C1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 23:59:26 +1000 (EST)
Received: by mail-we0-f181.google.com with SMTP id q59so2338334wes.26
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 06:59:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAF0T0X4=fynr+ou+LK58DwpFnz5rgPiqadykKXf-bsp7N0uaeA@mail.gmail.com>
References: <1403088492-15241-1-git-send-email-a13xp0p0v88@gmail.com>
 <1403088492-15241-2-git-send-email-a13xp0p0v88@gmail.com>
 <20140618133730.GB11895@leverpostej>
 <CAF0T0X4=fynr+ou+LK58DwpFnz5rgPiqadykKXf-bsp7N0uaeA@mail.gmail.com>
Date: Thu, 19 Jun 2014 17:59:19 +0400
Message-ID: <CAF0T0X5LPRtm6_Q5i0ncpA3NTWckYUwqXgBxGn5ydPMq40VHBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dmaengine: mpc512x: add device tree binding
 document
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2014-06-18 18:56 GMT+04:00 Alexander Popov <a13xp0p0v88@gmail.com>:
> 2014-06-18 17:37 GMT+04:00 Mark Rutland <mark.rutland@arm.com>:
>> On Wed, Jun 18, 2014 at 11:48:10AM +0100, Alexander Popov wrote:
>>> Introduce a device tree binding document for the MPC512x DMA controller
>>> +Optional properties:
>>> +- #dma-cells: the length of the DMA specifier, must be <1>.
>>> +     Each channel of this DMA controller has a peripheral request line,
>>> +     the assignment is fixed in hardware. This one cell
>>> +     in dmas property of a client device represents the channel number.
>>
>> Surely this is required to be able to refer to DMA channels on the
>> device?
>
> Excuse me, I didn't understand your question.
> Do you inquire about the reason of making #dma-cells an optional property?
> It's optional because device tree based lookup support is made
> optional (part 3/3).

Mark, did I answer your question?
Should I fix anything in this patch series?

Hope for the reply.
Alexander
