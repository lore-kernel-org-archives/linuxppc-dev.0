Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B11D71A0280
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 00:56:12 +1000 (EST)
Received: by mail-wi0-f175.google.com with SMTP id r20so7801128wiv.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 07:56:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140618133730.GB11895@leverpostej>
References: <1403088492-15241-1-git-send-email-a13xp0p0v88@gmail.com>
 <1403088492-15241-2-git-send-email-a13xp0p0v88@gmail.com>
 <20140618133730.GB11895@leverpostej>
Date: Wed, 18 Jun 2014 18:56:07 +0400
Message-ID: <CAF0T0X4=fynr+ou+LK58DwpFnz5rgPiqadykKXf-bsp7N0uaeA@mail.gmail.com>
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

Hello Mark, thanks for your reply!

2014-06-18 17:37 GMT+04:00 Mark Rutland <mark.rutland@arm.com>:
> On Wed, Jun 18, 2014 at 11:48:10AM +0100, Alexander Popov wrote:
>> Introduce a device tree binding document for the MPC512x DMA controller
>>
>> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
>> ---
>>  .../devicetree/bindings/dma/mpc512x-dma.txt        | 31 ++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/mpc512x-dma.txt b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
>> new file mode 100644
>> index 0000000..95e2ca0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
>> @@ -0,0 +1,31 @@
>> +* Freescale MPC512x and MPC8308 DMA Controller
>> +
>> +The DMA controller in Freescale MPC512x and MPC8308 SoCs can move
>> +blocks of memory contents between memory and peripherals or
>> +from memory to memory.
>> +
>> +Refer to "Generic DMA Controller and DMA request bindings" in
>> +the dma/dma.txt file for a more detailed description of binding.
>> +
>> +Required properties:
>> +- compatible: should be "fsl,mpc5121-dma" or "fsl,mpc8308-dma";
>> +- reg: should contain the DMA controller registers location and length;
>> +- interrupt for the DMA controller: syntax of interrupt client node
>> +     is described in interrupt-controller/interrupts.txt file.
>> +
>> +Optional properties:
>> +- #dma-cells: the length of the DMA specifier, must be <1>.
>> +     Each channel of this DMA controller has a peripheral request line,
>> +     the assignment is fixed in hardware. This one cell
>> +     in dmas property of a client device represents the channel number.
>
> Surely this is required to be able to refer to DMA channels on the
> device?

Excuse me, I didn't understand your question.
Do you inquire about the reason of making #dma-cells an optional property?
It's optional because device tree based lookup support is made
optional (part 3/3).

Best regards,
Alexander
