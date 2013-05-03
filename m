Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A7392C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 16:59:58 +1000 (EST)
Date: Fri, 3 May 2013 08:59:44 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH 1/1] powerpc: mpc512x_dma: add support for data
 transfers between memory and i/o memory
Message-ID: <20130503085944.69ef751e@crub>
In-Reply-To: <CAF0T0X7XBuL7a=8zwqMnLDB04-Tf=qhCLPZ4T29yNdN6mP5S2A@mail.gmail.com>
References: <1367407689-16252-1-git-send-email-a13xp0p0v88@gmail.com>
 <20130502171452.GP1960@intel.com>
 <CAF0T0X7XBuL7a=8zwqMnLDB04-Tf=qhCLPZ4T29yNdN6mP5S2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Vinod Koul <vinod.koul@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dan Williams <djbw@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 3 May 2013 10:28:02 +0400
Alexander Popov <a13xp0p0v88@gmail.com> wrote:

> Hello Vinod,
> 
> Thanks for the review.
> I will return with improved and tested version 2.

Note that there is a patch for .device_prep_slave_sg() operation
for this driver as part of this series:
https://patchwork.kernel.org/patch/2368581/
https://patchwork.kernel.org/patch/2368591/

maybe you can reuse and improve it.

Thanks,

Anatolij
