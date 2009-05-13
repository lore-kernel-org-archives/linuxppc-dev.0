Return-Path: <dan.j.williams@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id 61A9DDE00C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 07:48:49 +1000 (EST)
Received: by qyk29 with SMTP id 29so1639693qyk.15
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 14:48:47 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1242249957-10352-1-git-send-email-galak@kernel.crashing.org>
References: <1242249957-10352-1-git-send-email-galak@kernel.crashing.org>
Date: Wed, 13 May 2009 14:40:41 -0700
Message-ID: <e9c3a7c20905131440n7a8c66a2j73997e44db7e4d97@mail.gmail.com>
Subject: Re: [PATCH] fsldma: Fix compile warnings
From: Dan Williams <dan.j.williams@intel.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 13, 2009 at 2:25 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> We we build with dma_addr_t as a 64-bit quantity we get:
>
> drivers/dma/fsldma.c: In function 'fsl_chan_xfer_ld_queue':
> drivers/dma/fsldma.c:625: warning: cast to pointer from integer of different size
> drivers/dma/fsldma.c: In function 'fsl_dma_chan_do_interrupt':
> drivers/dma/fsldma.c:737: warning: cast to pointer from integer of different size
> drivers/dma/fsldma.c:737: warning: cast to pointer from integer of different size
> drivers/dma/fsldma.c: In function 'of_fsl_dma_probe':
> drivers/dma/fsldma.c:927: warning: cast to pointer from integer of different
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Dan Williams <dan.j.williams@intel.com>

I'm fine with this going through your tree.

Thanks,
Dan
