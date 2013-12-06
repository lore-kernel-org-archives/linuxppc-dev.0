Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com
 [IPv6:2a00:1450:400c:c05::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6210E2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 07:41:07 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <52A234F5.9030300@metafoo.de>
References: <1380809202-16192-1-git-send-email-a13xp0p0v88@gmail.com>
 <20131006111038.GN14747@book.gsilab.sittig.org>
 <CAF0T0X6XhHk5qhwk=Kzu_YvMNduZaMqNxGWRyyeNP8LWzDJziw@mail.gmail.com>
 <52A234F5.9030300@metafoo.de>
Date: Sat, 7 Dec 2013 00:41:03 +0400
Message-ID: <CAF0T0X58_UhQU9FL-ZxZy5r3syTa2o7Y9F3ZbGo4w1YyA1Dmtg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/5] dma: mpc512x: add support for peripheral
 transfers
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 Gerhard Sittig <gsi@denx.de>, Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/12/7 Lars-Peter Clausen <lars@metafoo.de>:
> On 12/06/2013 09:27 PM, Alexander Popov wrote:
>>
>> 2013/10/6 Gerhard Sittig <gsi@denx.de>:
>>    * struct dma_slave_config - dma slave channel runtime config
>>    * @direction: whether the data shall go in or out on this slave
>>    * channel, right now. DMA_TO_DEVICE and DMA_FROM_DEVICE are
>>    * legal values, DMA_BIDIRECTIONAL is not acceptable since we
>>    * need to differentiate source and target addresses.
>>    ...
>>    struct dma_slave_config {
>>            enum dma_transfer_direction direction;
>>            ...
>>    };
>>
>> The comment above the definition is obsolete, isn't it?
>
>
> Yes, the comment seems to be out of date. Care to send a patch fixing it?

Yes, I will prepare and send the patch.

Thanks
Alexander
