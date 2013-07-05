Return-Path: <thomas.petazzoni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [94.23.35.102])
 by ozlabs.org (Postfix) with ESMTP id EC3FC2C038A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 07:40:38 +1000 (EST)
Date: Fri, 5 Jul 2013 23:40:34 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
Message-ID: <20130705234034.6c57cd43@skate>
In-Reply-To: <CAErSpo4HoofGhN8VumRnN0sN_+gWJ9gVQJVMiePnDBUKwh74ag@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5uCpQftDmsMYEsFMtt_LP3kZPQ3Y4zz4VT7GdpcFq+1w@mail.gmail.com>
 <CAErSpo4HoofGhN8VumRnN0sN_+gWJ9gVQJVMiePnDBUKwh74ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Jason Cooper <jason@lakedaemon.net>,
 Rob Herring <rob.herring@calxeda.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 Maen Suleiman <maen@marvell.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Bjorn Helgaas,

On Fri, 5 Jul 2013 15:34:10 -0600, Bjorn Helgaas wrote:
> On Fri, Jul 5, 2013 at 3:32 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> But please update your subject line to use consistent capitalization, e.g.,
> 
> PCI: Use weak ...

Sure, will do.

Would it be possible to get Tested-by and/or Acked-by from the
different architecture maintainers affected by PATCH 02/11 and PATCH
03/11 ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
