Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WWx02cqKzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 21:28:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>, Geoff Levand <geoff@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-usb@vger.kernel.org,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/ps3: Set driver coherent_dma_mask
In-Reply-To: <20180719065503.GB21108@kroah.com>
References: <068ebcfa-7cd0-bd06-42e7-577a4624f0b0@infradead.org>
 <20180719065503.GB21108@kroah.com>
Date: Thu, 19 Jul 2018 21:28:29 +1000
Message-ID: <87bmb3cvmq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Jul 18, 2018 at 03:08:33PM -0700, Geoff Levand wrote:
>> Set the coherent_dma_mask for the PS3 ehci, ohci, and snd devices.
>> 
>> Silences WARN_ON_ONCE messages emitted by the dma_alloc_attrs() routine.
>> 
>> Reported-by: Fredrik Noring <noring@nocrew.org>
>> Signed-off-by: Geoff Levand <geoff@infradead.org>
>> ---
>> Hi Michael,
>> 
>> This just silences some warnings.  Can you take it through the powerpc
>> tree?
>
> Oops, nevermind, it should go through the ppc tree.  Here's my ack:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

OK thanks, I'll take it.

cheers
