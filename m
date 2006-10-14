Return-Path: <jschopp@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0443C67C67
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 12:12:33 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9E2COQt029145
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 22:12:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9E2COV0263462
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 22:12:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9E2CNt4024685
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 22:12:23 -0400
Message-ID: <45304771.70606@austin.ibm.com>
Date: Fri, 13 Oct 2006 21:12:01 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
References: <20061010204946.GW4381@austin.ibm.com>
	<20061010212324.GR4381@austin.ibm.com>
In-Reply-To: <20061010212324.GR4381@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@osdl.org, jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> The current driver code performs 512 DMA mappns of a bunch of 
> 32-byte structures. This is silly, as they are all in contiguous 
> memory. Ths patch changes the code to DMA map the entie area
> with just one call.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: James K Lewis <jklewis@us.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

While this patch wasn't useful in the current cell implementation of pci_map_single 
it sounds like people are going to be making changes to that sometime. In light of 
that new information (new to me anyway) this should probably go in after all.  Sorry 
for causing trouble.

Acked-by: Joel Schopp <jschopp@austin.ibm.com>
