Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 7960B67B8B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 05:49:43 +1000 (EST)
To: Olof Johansson <olof@lixom.net>
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122956.2cebd36d@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 05 Sep 2006 12:49:39 -0700
In-Reply-To: <20060905122956.2cebd36d@localhost.localdomain> (Olof Johansson's
	message of "Tue, 5 Sep 2006 12:29:56 -0500")
Message-ID: <ada4pvmf60c.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > +#include <linux/config.h>
 > +#include <linux/init.h>
 > +#include <linux/errno.h>
 > +#include <linux/sched.h>
 > +#include <linux/kernel.h>
 > +#include <linux/mm.h>
 > +#include <linux/stddef.h>
 > +#include <linux/unistd.h>
 > +#include <linux/ptrace.h>
 > +#include <linux/slab.h>
 > +#include <linux/user.h>
 > +#include <linux/a.out.h>
 > +#include <linux/tty.h>
 > +#include <linux/string.h>
 > +#include <linux/delay.h>
 > +#include <linux/ioport.h>
 > +#include <linux/major.h>
 > +#include <linux/initrd.h>
 > +#include <linux/vt_kern.h>
 > +#include <linux/console.h>
 > +#include <linux/ide.h>
 > +#include <linux/pci.h>
 > +#include <linux/adb.h>
 > +#include <linux/cuda.h>
 > +#include <linux/pmu.h>
 > +#include <linux/irq.h>
 > +#include <linux/seq_file.h>
 > +#include <linux/root_dev.h>
 > +#include <linux/serial.h>
 > +#include <linux/smp.h>
 > +
 > +#include <asm/processor.h>
 > +#include <asm/sections.h>
 > +#include <asm/prom.h>
 > +#include <asm/system.h>
 > +#include <asm/pgtable.h>
 > +#include <asm/bitops.h>
 > +#include <asm/io.h>
 > +#include <asm/pci-bridge.h>
 > +#include <asm/iommu.h>
 > +#include <asm/machdep.h>
 > +#include <asm/dma.h>
 > +#include <asm/cputable.h>
 > +#include <asm/time.h>
 > +#include <asm/of_device.h>
 > +#include <asm/lmb.h>
 > +#include <asm/mpic.h>
 > +#include <asm/smp.h>
 > +#include <asm/udbg.h>
 > +#include <asm/serial.h>

Are all of these really needed?  Seems rather crazy, considering there
are only 145 lines after this in the file...
