Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x235.google.com (mail-it0-x235.google.com
 [IPv6:2607:f8b0:4001:c0b::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415JJy2QNdzDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:28:48 +1000 (AEST)
Received: by mail-it0-x235.google.com with SMTP id u4-v6so2525756itg.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 00:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
 <1528871397-17917-2-git-send-email-kernelfans@gmail.com>
 <20180613063710.GA30350@infradead.org>
In-Reply-To: <20180613063710.GA30350@infradead.org>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 13 Jun 2018 15:28:35 +0800
Message-ID: <CAFgQCTt+iWc2qoGyRxEq=f2x0tZQbbweMz_oq3qhuBG5e_GDUA@mail.gmail.com>
Subject: Re: [patchV2 1/2] pci: introduce an extra method for matching in
 pci_driver
To: hch@infradead.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2018 at 2:37 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> If we successfull call ->probe twice on a device we have a much
> deeper problem than we can fix in the PCI layer or shpchp.
>
OK, see your point.

> Please explain the actual race or other condition that can lead to
> this and report it to the driver core maintainer.
Oh, then it should be. I will add more debug info to narrow down the
problem, and report it to driver core maintainer.

Thanks for your kindly review.

Regards,
Pingfan
