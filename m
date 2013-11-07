Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-we0-x231.google.com (mail-we0-x231.google.com
 [IPv6:2a00:1450:400c:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 892A42C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 22:33:16 +1100 (EST)
Received: by mail-we0-f177.google.com with SMTP id x55so369045wes.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 03:33:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201311010852.05709.arnd@arndb.de>
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
 <1383290374-17484-4-git-send-email-a13xp0p0v88@gmail.com>
 <201311010852.05709.arnd@arndb.de>
Date: Thu, 7 Nov 2013 15:33:10 +0400
Message-ID: <CAF0T0X5Qxa5yGVrL2U2DfAuXcYx23WObA2BArG74+ZBFbwKb6g@mail.gmail.com>
Subject: Re: [PATCH RFC v5 3/5] dma: of: Add common xlate function for
 matching by channel id
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/11/1 Arnd Bergmann <arnd@arndb.de>:
> On Friday 01 November 2013, Alexander Popov wrote:
>> + * of_dma_xlate_by_chan_id - Translate dt property to DMA channel by channel id
>> + * @dma_spec:        pointer to DMA specifier as found in the device tree
>> + * @of_dma:  pointer to DMA controller data
>
> This seems rather clumsy, now that we have added the dma_get_slave_channel interface.
> Can you try using that instead of dma_request_channel() now?
>

Thanks, Arnd.
I'll return with the fixed version.

Best regards,
Alexander.
