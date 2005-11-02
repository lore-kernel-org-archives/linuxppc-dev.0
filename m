Return-Path: <SRS0+e5d05c376b37d7088a49+801+infradead.org+dwmw2@baythorne.srs.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17256.4190.184855.821331@cargo.ozlabs.ibm.com>
References: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
	<1130860444.21212.52.camel@hades.cambridge.redhat.com>
	<17256.4190.184855.821331@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 09:06:19 +0000
Message-Id: <1130922379.10031.154.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: please pull the powerpc-merge.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-11-02 at 12:03 +1100, Paul Mackerras wrote:
> That's probably either the pci quirk that got added to do USB host
> controller handoff unconditionally on all platforms, and which touches
> the device without doing pci_enable_device or checking whether MMIO is
> enabled.  A fix has gone into Linus' tree for that.
> 
> There was also a bug added to the adbhid.c driver which would cause an
> oops when you pressed a key if you had an ADB keyboard (which
> powerbooks do).  That's also fixed in Linus' tree.

It was neither of those -- after a few warnings about sleeping in
inappropriate contexts it just seems to stop. The Pegasos is a little
more informative -- lots of 'hda: lost interrupt' on that. Keyboard
seems to work though, and Bogomips calculation -- so maybe it's just PCI
interrupts which are missing. I'll poke at it further.

I'll also try again on the powerbook today and see if I can get anything
more useful out of it.

-- 
dwmw2
