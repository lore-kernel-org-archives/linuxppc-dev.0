Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WPrp4hwLzDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:54:33 +1000 (AEST)
Date: Thu, 19 Jul 2018 08:54:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jaroslav Kysela <perex@perex.cz>, Alan Stern <stern@rowland.harvard.edu>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Set driver coherent_dma_mask
Message-ID: <20180719065429.GA21108@kroah.com>
References: <068ebcfa-7cd0-bd06-42e7-577a4624f0b0@infradead.org>
 <s5hin5b67u2.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hin5b67u2.wl-tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 19, 2018 at 08:46:45AM +0200, Takashi Iwai wrote:
> On Thu, 19 Jul 2018 00:08:33 +0200,
> Geoff Levand wrote:
> > 
> > Set the coherent_dma_mask for the PS3 ehci, ohci, and snd devices.
> > 
> > Silences WARN_ON_ONCE messages emitted by the dma_alloc_attrs() routine.
> > 
> > Reported-by: Fredrik Noring <noring@nocrew.org>
> > Signed-off-by: Geoff Levand <geoff@infradead.org>
> 
> For sound bits,
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks, I'll take this through the USB tree then.

greg k-h
