Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id B84FF2C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 11:51:27 +1000 (EST)
Date: Mon, 20 May 2013 18:51:22 -0700 (PDT)
Message-Id: <20130520.185122.248131229922415805.davem@davemloft.net>
To: bhelgaas@google.com
Subject: Re: [PATCH 2/2] sparc/PCI: Use PCI_UNKNOWN for unknown power state
From: David Miller <davem@davemloft.net>
In-Reply-To: <20130520231916.32416.7318.stgit@bhelgaas-glaptop>
References: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
 <20130520231916.32416.7318.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: rjw@sisk.pl, paulus@samba.org, linux-pci@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 May 2013 17:19:16 -0600

> Previously we initialized dev->current_state to 4 (PCI_D3cold), but I think
> we wanted PCI_UNKNOWN (5) here based on the comment and the fact that the
> generic version of this code, pci_setup_device(), uses PCI_UNKNOWN.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
