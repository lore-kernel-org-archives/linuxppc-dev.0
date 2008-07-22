Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 59737DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 10:45:18 +1000 (EST)
Date: Mon, 21 Jul 2008 20:38:14 -0400
From: Dave Jones <davej@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] serial: fix struct uart_info change fallout
Message-ID: <20080722003814.GA14809@redhat.com>
References: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 10:25:20AM +1000, Stephen Rothwell wrote:
 > Hi Linus, Alan,
 > 
 > Today's linux-next (actually just Linus' tree) build (powerpc
 > ppc64_defconfig) failed like this:
 > 
 > drivers/serial/serial_txx9.c: In function 'receive_chars':
 > drivers/serial/serial_txx9.c:275: error: 'struct uart_info' has no member named 'tty'
 > drivers/serial/icom.c: In function 'recv_interrupt':
 > drivers/serial/icom.c:733: error: 'struct uart_info' has no member named 'tty'

That's the same pair of patches I sent earlier, which apparently were
"Already in the ttydev tree" which should be in linux-next ?

	Dave
 
-- 
http://www.codemonkey.org.uk
