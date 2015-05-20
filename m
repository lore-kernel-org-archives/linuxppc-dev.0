Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BAE61A060E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 00:52:19 +1000 (AEST)
Date: Wed, 20 May 2015 16:50:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch v2 08/14] genirq: Introduce helper function
 irq_data_get_affinity_mask()
In-Reply-To: <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505201648490.4225@nanos>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
 <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Larsson <andreas@gaisler.com>, linux-mips@linux-mips.org,
 Kevin Cernekee <cernekee@gmail.com>, linux-ia64@vger.kernel.org,
 Brian Gerst <brgerst@gmail.com>, David Daney <david.daney@cavium.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>,
 bob picco <bpicco@meloft.net>, linux-am33-list@redhat.com,
 Russell King <linux@arm.linux.org.uk>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-sh@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-acpi@vger.kernel.org,
 linux-alpha@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <rmk+kernel@arm.linux.org.uk>, Matt Turner <mattst88@gmail.com>,
 Aleksey Makarov <aleksey.makarov@auriga.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Steven Miao <realmz6@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-xtensa@linux-xtensa.org,
 Rusty Russell <rusty@rustcorp.com.au>,
 adi-buildroot-devel@lists.sourceforge.net, Jonas Gorski <jogo@openwrt.org>,
 Simon Horman <horms@verge.net.au>, Borislav Petkov <bp@alien8.de>,
 Anton Blanchard <anton@samba.org>, xen-devel@lists.xenproject.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Yinghai Lu <yinghai@kernel.org>,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, David Vrabel <david.vrabel@citrix.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Tejun Heo <tj@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 May 2015, Jiang Liu wrote:

> Introduce helper function irq_data_get_affinity_mask() and
> irq_get_affinity_mask() to hide implementation details,

That patch does way more than introducing the functions. Again:

Patch 1: Introduce helpers

Patch 2-n: Convert users subsystem wise

Thanks,

	tglx
