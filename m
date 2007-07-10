Return-Path: <dan.j.williams@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 29523DDF21
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 04:41:33 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so248278anc
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 11:41:33 -0700 (PDT)
Message-ID: <e9c3a7c20707101141m17e313e2k99be5b7197edc910@mail.gmail.com>
Date: Tue, 10 Jul 2007 11:41:32 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Zhang Wei" <wei.zhang@freescale.com>
Subject: Re: [PATCH 3/4] Extend the DMA-engine API.
In-Reply-To: <11840607111926-git-send-email-wei.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11840607111926-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/10/07, Zhang Wei <wei.zhang@freescale.com> wrote:
> Add channel wait queue and transfer callback dma_xfer_callback().
> If the DMA controller and driver support interrupt, when the
> transfer is finished, it will wakeup the wait queue
> and call the callback function of the channel.
>
> Add dma_async_raw_xfer() to API and device_raw_xfer() to struct dma_device
> for RAW physical address DMA transfer, which will be used at transfer
> between I/O address and memory address.
>

Please review the async_tx API patch series[1], it should meet your
needs.  What you call "raw" mode support is now default for the
dmaengine driver interface.  I plan to request that this series be
merged for 2.6.23.

Regards,
Dan

[1]http://marc.info/?l=linux-raid&w=2&r=1&s=md-accel&q=b
