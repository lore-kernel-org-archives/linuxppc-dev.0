Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by ozlabs.org (Postfix) with ESMTP id 7E167DE13B
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 09:53:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Date: Thu, 15 Jan 2009 23:53:24 +0100
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901152222.55006.arnd@arndb.de>
	<20090115214056.GC9091@ovro.caltech.edu>
In-Reply-To: <20090115214056.GC9091@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901152353.25052.arnd@arndb.de>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, shemminger@vyatta.com,
	David Miller <davem@davemloft.net>, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 January 2009, Ira Snyder wrote:
> I do have mailboxes (two inbound, two outbound) which can generate
> interrupts, as well as doorbell registers (one inbound, one outbound).
> The doorbell register's bits are "write 1 to clear", and can only be
> cleared by the opposite side.
> 

Ok, in this case, you should be able to use one of these to implement
the DMA complete interrupt, but adding an extra DMA transfer to the
mailbox after each transfer that you want to get notified for.

	Arnd <><
