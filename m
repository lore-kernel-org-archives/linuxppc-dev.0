Return-Path: <macro@linux-mips.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [78.24.191.182])
	by ozlabs.org (Postfix) with ESMTP id 98145B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 02:43:39 +1000 (EST)
Received: from localhost.localdomain ([127.0.0.1]:33471 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1491020Ab0IBQnf (ORCPT
	<rfc822;linuxppc-dev@lists.ozlabs.org>);
	Thu, 2 Sep 2010 18:43:35 +0200
Date: Thu, 2 Sep 2010 17:43:35 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: David Miller <davem@davemloft.net>
Subject: Re: ERR_PTR pattern in phylib
In-Reply-To: <20100902.093451.189703514.davem@davemloft.net>
Message-ID: <alpine.LFD.2.00.1009021735320.410@eddie.linux-mips.org>
References: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
	<alpine.LFD.2.00.1009021617500.410@eddie.linux-mips.org>
	<20100902.093451.189703514.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@vger.kernel.org, afleming@freescale.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Sep 2010, David Miller wrote:

> >  Arguably using a union here would make things cleaner and any reasonable 
> > ABI will place small unions used as arguments or return values in 
> > registers, but I'm not sure if the cost of the rewrite is worth the 
> 
> Well, sparc 32-bit's ABI for one is "not reasonable" and these return
> values will always get stack slots and passed back by reference.

 So that makes it two -- together with MIPS o32. ;)  Still used by 
everybody concerned as contraptions tend to stick. :/  That doesn't make 
it reasonable though.  Nor me to push the union approach -- that's an 
elegant approach that would probably give us less than take in return.

  Maciej
