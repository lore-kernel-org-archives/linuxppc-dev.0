Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WPsR6Ph4zDqDR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:55:07 +1000 (AEST)
Date: Thu, 19 Jul 2018 08:55:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Geoff Levand <geoff@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-usb@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/ps3: Set driver coherent_dma_mask
Message-ID: <20180719065503.GB21108@kroah.com>
References: <068ebcfa-7cd0-bd06-42e7-577a4624f0b0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <068ebcfa-7cd0-bd06-42e7-577a4624f0b0@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2018 at 03:08:33PM -0700, Geoff Levand wrote:
> Set the coherent_dma_mask for the PS3 ehci, ohci, and snd devices.
> 
> Silences WARN_ON_ONCE messages emitted by the dma_alloc_attrs() routine.
> 
> Reported-by: Fredrik Noring <noring@nocrew.org>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> Hi Michael,
> 
> This just silences some warnings.  Can you take it through the powerpc
> tree?

Oops, nevermind, it should go through the ppc tree.  Here's my ack:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
