Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6C676DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 15:51:24 +1000 (EST)
Date: Thu, 08 May 2008 22:51:16 -0700 (PDT)
Message-Id: <20080508.225116.02056221.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH]: PPC_OF protect USB driver...
From: David Miller <davem@davemloft.net>
In-Reply-To: <18467.57545.798170.20885@cargo.ozlabs.ibm.com>
References: <20080505.005715.215572318.davem@davemloft.net>
	<18467.57545.798170.20885@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Fri, 9 May 2008 15:27:37 +1000

> David Miller writes:
> 
> > This uses APIs that are not generic, or at least not part of
> > what Sparc provides yet.
> > 
> > So just PPC_OF this for now just like the EHCI_OF driver.
> > 
> > This fixes allmodconfig build errors on sparc.
> 
> Are you going to send this to the USB maintainers, or are you going to
> merge it to Linus, or do you want me to?

It is in Linus's tree after a sparc push I sent to him yesterday.

Thanks Paul.
