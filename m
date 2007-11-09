Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E13C8DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 11:16:28 +1100 (EST)
Date: Thu, 8 Nov 2007 18:16:37 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Use SLB size from the device tree
Message-ID: <20071109001637.GA32488@lixom.net>
References: <510.1194565218@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510.1194565218@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Will Schmidt <will_schmidt@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 09, 2007 at 10:40:18AM +1100, Michael Neuling wrote:
> Currently we hardwire the number of SLBs but the PAPR says we export an
> ibm,slb-size property to specify the number of SLB entries.  This patch
> uses this property instead of assuming 64 always.  If no property is
> found, we assume 64 entries as before.
> 
> This soft patches the SLB handler, so it won't change performance at
> all.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Olof Johansson <olof@lixom.net>

I wonder if it isn't time soon to move all the mmu_.* globals to a
struct. That's a separate issue though.


-Olof
