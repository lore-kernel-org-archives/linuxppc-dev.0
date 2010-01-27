Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-313.bluehost.com (outbound-mail-313.bluehost.com
	[67.222.54.6]) by ozlabs.org (Postfix) with SMTP id 24AD6B80CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jan 2010 03:40:39 +1100 (EST)
Date: Wed, 27 Jan 2010 08:33:43 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/pci: Add calls to set_pcie_port_type() and
	set_pcie_hotplug_bridge()
Message-ID: <20100127083343.03a4ce32@jbarnes-piketon>
In-Reply-To: <1264561803.3601.163.camel@pasglop>
References: <1264561803.3601.163.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jan 2010 14:10:03 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> We are missing these when building the pci_dev from scratch off
> the Open Firmware device-tree
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/pci_of_scan.c |    2 ++
>  drivers/pci/probe.c               |    4 ++--
>  include/linux/pci.h               |    4 ++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> Jesse, can I have an ack for the generic bits ? Note that I couldn't test
> on a pSeries machine with PCI-E as all such machines in ozlabs currently
> have all their partitions with PCI-E devices in them in FAIL state in ABAT
> and our admin is out.

Yeah, generic bits look fine.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
