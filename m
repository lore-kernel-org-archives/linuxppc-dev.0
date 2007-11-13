Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A2157DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 18:05:18 +1100 (EST)
Date: Tue, 13 Nov 2007 01:06:04 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Merge pci_process_bridge_OF_ranges()
Message-ID: <20071113070604.GA16842@lixom.net>
References: <20071113044432.F1389DDE2E@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113044432.F1389DDE2E@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 13, 2007 at 03:43:51PM +1100, Benjamin Herrenschmidt wrote:
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Tested on a few pSeries, PowerMac G5, and a 32 bits PowerMacs and
> a BriQ. Please let me know if it misbehaves anywhere else.

Looks good on the eval boards I tested here.

Acked-by: Olof Johansson <olof@lixom.net>
