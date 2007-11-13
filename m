Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D83DBDDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 20:56:51 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc: Merge pci_process_bridge_OF_ranges()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071113070604.GA16842@lixom.net>
References: <20071113044432.F1389DDE2E@ozlabs.org>
	<20071113070604.GA16842@lixom.net>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 20:56:41 +1100
Message-Id: <1194947801.18185.99.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-11-13 at 01:06 -0600, Olof Johansson wrote:
> On Tue, Nov 13, 2007 at 03:43:51PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > Tested on a few pSeries, PowerMac G5, and a 32 bits PowerMacs and
> > a BriQ. Please let me know if it misbehaves anywhere else.
> 
> Looks good on the eval boards I tested here.
> 
> Acked-by: Olof Johansson <olof@lixom.net>

Thanks for testing.

Ben.
