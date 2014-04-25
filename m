Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
 by ozlabs.org (Postfix) with ESMTP id 380F31400B2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Apr 2014 02:58:11 +1000 (EST)
Date: Fri, 25 Apr 2014 12:49:03 -0400 (EDT)
Message-Id: <20140425.124903.145066741692796378.davem@davemloft.net>
To: wangyijing@huawei.com
Subject: Re: [PATCH 07/13] sparc/PCI: Use new pci_is_bridge() to simplify code
From: David Miller <davem@davemloft.net>
In-Reply-To: <1398417515-8740-8-git-send-email-wangyijing@huawei.com>
References: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
 <1398417515-8740-8-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, bhelgaas@google.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yijing Wang <wangyijing@huawei.com>
Date: Fri, 25 Apr 2014 17:18:29 +0800

> Now we can use new pci_is_bridge() helper function
> to simplify code.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
