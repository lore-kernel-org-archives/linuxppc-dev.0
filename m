Return-Path: <ralf@linux-mips.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by lists.ozlabs.org (Postfix) with ESMTP id 3y9gkM3TBMzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 00:16:43 +1100 (AEDT)
Received: from localhost.localdomain ([127.0.0.1]:54524 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S23992675AbdJINMh7ZtxY (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Mon, 9 Oct 2017 15:12:37 +0200
Date: Mon, 9 Oct 2017 15:12:27 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 linux-xtensa@linux-xtensa.org, Mikael Starvik <starvik@axis.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
 Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
 linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/4] PCI: Remove redundant pci_dev, pci_bus, resource
 declarations
Message-ID: <20171009131227.GG20977@linux-mips.org>
References: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171005203849.18300.20999.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171005203849.18300.20999.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 05, 2017 at 03:38:49PM -0500, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> <linux/pci.h> defines struct pci_bus and struct pci_dev and includes the
> struct resource definition before including <asm/pci.h>.  Nobody includes
> <asm/pci.h> directly, so they don't need their own declarations.
> 
> Remove the redundant struct pci_dev, pci_bus, resource declarations.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

For MIPS:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
