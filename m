Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 58EE8B6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 18:33:53 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/7] serial/8250: move UPIO_TSI to powerpc
Date: Thu, 01 Sep 2011 10:28:12 +0200
Message-ID: <4560783.75JgbxnBn8@wuerfel>
In-Reply-To: <1314856926.4145.12.camel@pasglop>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-4-git-send-email-arnd@arndb.de>
	<1314856926.4145.12.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 01 September 2011 16:02:06 Benjamin Herrenschmidt wrote:
> On Mon, 2011-06-27 at 23:45 +0200, Arnd Bergmann wrote:
> > This iotype is only used by the legacy_serial code in powerpc, so the
> > code should live there, rather than be compiled in for every 8250
> > driver.
> 
> Obviously untested 
> 
> Misses the definition of UART_IIR etc...
> 
> I'm committing a fixed version in my tree

Ok, thank you!

	Arnd
