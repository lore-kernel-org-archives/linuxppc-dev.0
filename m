Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 0B969DE112
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 08:23:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Date: Thu, 15 Jan 2009 22:22:53 +0100
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901151853.52202.arnd@arndb.de>
	<20090115192129.GB9091@ovro.caltech.edu>
In-Reply-To: <20090115192129.GB9091@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901152222.55006.arnd@arndb.de>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, Ira Snyder <iws@ovro.caltech.edu>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, shemminger@vyatta.com,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 January 2009, Ira Snyder wrote:
> I have another question for you Arnd.
> 
> What did you use as the host and guest drivers when you ran virtio over
> PCI? Did you use two unmodified instances of virtio_net (one on host,
> one on guest) for networking, or did you write new virtio drivers for
> those? How about for virtio_console (if you ran it at all).

Jan-Bernd may be able to tell you details about this, and send you the
driver code that his interns implemented for it.
This was only doing virtio_net between two machines using MMIO transfers,
i.e. the DMA engine was unused, but there was a mailbox interrupt (if you
have one of these, you won't need MSI, btw -- just write a DMA to it).

	Arnd <><
