Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Q8v4dKpzDqG2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 07:58:23 +1100 (AEDT)
Date: Thu, 5 Oct 2017 22:57:16 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>,
 linux-am33-list@redhat.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-xtensa@linux-xtensa.org,
 Mikael Starvik <starvik@axis.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
 linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] PCI: Remove redundant pcibios_set_master()
 declarations
In-Reply-To: <20171005203842.18300.67328.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.20.1710052256540.2398@nanos>
References: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171005203842.18300.67328.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 5 Oct 2017, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> All users of pcibios_set_master() include <linux/pci.h>, which already has
> a declaration.  Remove the unnecessary declarations from the <asm/pci.h>
> files.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
