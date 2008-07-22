Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00BAFDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 12:17:44 +1000 (EST)
Date: Tue, 22 Jul 2008 03:00:11 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] serial: fix struct uart_info change fallout
Message-ID: <20080722030011.6b0d8137@lxorguk.ukuu.org.uk>
In-Reply-To: <20080722003814.GA14809@redhat.com>
References: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
	<20080722003814.GA14809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Jul 2008 20:38:14 -0400
Dave Jones <davej@redhat.com> wrote:

> On Tue, Jul 22, 2008 at 10:25:20AM +1000, Stephen Rothwell wrote:
>  > Hi Linus, Alan,
>  > 
>  > Today's linux-next (actually just Linus' tree) build (powerpc
>  > ppc64_defconfig) failed like this:
>  > 
>  > drivers/serial/serial_txx9.c: In function 'receive_chars':
>  > drivers/serial/serial_txx9.c:275: error: 'struct uart_info' has no member named 'tty'
>  > drivers/serial/icom.c: In function 'recv_interrupt':
>  > drivers/serial/icom.c:733: error: 'struct uart_info' has no member named 'tty'
> 
> That's the same pair of patches I sent earlier, which apparently were
> "Already in the ttydev tree" which should be in linux-next ?

And are in Linux next, and would be in the Linus submission queue except
that everyone keeps patching tty files from other trees.

<mutter>

Alan
