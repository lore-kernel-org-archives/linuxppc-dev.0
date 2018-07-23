Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4hD0P1XzDrVM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:24 +1000 (AEST)
In-Reply-To: <068ebcfa-7cd0-bd06-42e7-577a4624f0b0@infradead.org>
To: Geoff Levand <geoff@infradead.org>, Alan Stern <stern@rowland.harvard.edu>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-usb@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: powerpc/ps3: Set driver coherent_dma_mask
Message-Id: <41Z4hC06hpz9s5f@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-18 at 22:08:33 UTC, Geoff Levand wrote:
> Set the coherent_dma_mask for the PS3 ehci, ohci, and snd devices.
> 
> Silences WARN_ON_ONCE messages emitted by the dma_alloc_attrs() routine.
> 
> Reported-by: Fredrik Noring <noring@nocrew.org>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/48e91846865cd61bfdb701eb737de2

cheers
