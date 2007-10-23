Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 601F7DDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:23:12 +1000 (EST)
Date: Mon, 22 Oct 2007 17:23:32 -0700 (PDT)
Message-Id: <20071022.172332.112621497.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [BUG] powerpc does not save msi state [was Re: [PATCH 5/7]
	pci: Export the pci_restore_msi_state() function
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071022195451.GE4280@austin.ibm.com>
References: <20071020004610.GR29903@austin.ibm.com>
	<20071019.175308.54212640.davem@davemloft.net>
	<20071022195451.GE4280@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, mcarlson@broadcom.com, linuxppc-dev@ozlabs.org,
	mchan@broadcom.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Mon, 22 Oct 2007 14:54:52 -0500

> As discussed in the other thread, I'll try to set up a patch
> for an arch callback for restoring msi state.

Thank you.
