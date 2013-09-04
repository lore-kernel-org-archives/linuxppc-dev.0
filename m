Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 86DBF2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 07:10:04 +1000 (EST)
Subject: Re: [PATCH 3/7] powerpc/pci: use pci_is_pcie() to simplify code
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1378193715-25328-3-git-send-email-wangyijing@huawei.com>
Date: Wed, 4 Sep 2013 16:07:15 -0500
Message-Id: <F405FCAB-60A8-4341-AEA5-A9E20CDCB85C@kernel.crashing.org>
References: <1378193715-25328-1-git-send-email-wangyijing@huawei.com>
 <1378193715-25328-3-git-send-email-wangyijing@huawei.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, Hanjun Guo <guohanjun@huawei.com>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 3, 2013, at 2:35 AM, Yijing Wang wrote:

> Use pci_is_pcie() to simplify code.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
> arch/powerpc/kernel/eeh.c     |    3 +--
> arch/powerpc/sysdev/fsl_pci.c |    2 +-
> 2 files changed, 2 insertions(+), 3 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

(for the fsl_pci.c) change

- k
 
