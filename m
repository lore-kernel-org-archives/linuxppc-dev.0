Return-Path: <hongbo.zhang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B3B9214008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 19:34:03 +1000 (EST)
Message-ID: <53466573.7050901@freescale.com>
Date: Thu, 10 Apr 2014 17:33:39 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>, "vkoul@infradead.org"
 <vkoul@infradead.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] DMA: Freescale: unify register access methods
References: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>
 <1397113805-24171-3-git-send-email-hongbo.zhang@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6F4317@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6F4317@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "leo.li@freescale.com" <leo.li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04/10/2014 04:46 PM, David Laight wrote:
> From: hongbo.zhang@freescale.com
>> Methods of accessing DMA contorller registers are inconsistent, some registers
>                                 ^^

Thanks.
sorry, that it a typo.
I would wait to see if there are other defects I have to correct, if yes 
I can send a new iteration including this update, if no I would like to 
know if the maintainer can do me the favor to correct it when merging 
this patch, if still no, I will send a new iteration for this then.

>> are accessed by DMA_IN/OUT directly, while others are accessed by functions
>> get/set_* which are wrappers of DMA_IN/OUT, and even for the BCR register, it
>> is read by get_bcr but written by DMA_OUT.
>> This patch unifies the inconsistent methods, all registers are accessed by
>> get/set_* now.
> 	David
>
