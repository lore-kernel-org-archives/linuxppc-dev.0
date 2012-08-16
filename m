Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C32942C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 00:25:03 +1000 (EST)
Date: Thu, 16 Aug 2012 15:29:18 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Message-ID: <20120816152918.5ed2649f@pyramind.ukuu.org.uk>
In-Reply-To: <502CF2A0.8080109@c-s.fr>
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
 <20120814155227.018988da@pyramind.ukuu.org.uk>
 <502CF2A0.8080109@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The PowerPC CPM is working differently. It doesn't use a fifo but 
> buffers. Buffers are handed to the microprocessor only when they are 
> full or after a timeout period which is adjustable. In the driver, the 

Which is different how - remembering we empty the FIFO on an IRQ

> buffers are configured with a size of 32 bytes. And the timeout is set 
> to the size of the buffer. That is this timeout that I'm reducing to 1 
> byte in my proposed patch. I can't see what it would break for high 
> speed I/O.

How can a timeout be measured in "bytes". Can we have a bit more clarity
on how the hardware works and take it from there ?

Alan
