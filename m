Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CC64BB7170
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 02:34:36 +1000 (EST)
Date: Thu, 02 Sep 2010 09:34:51 -0700 (PDT)
Message-Id: <20100902.093451.189703514.davem@davemloft.net>
To: macro@linux-mips.org
Subject: Re: ERR_PTR pattern in phylib
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LFD.2.00.1009021617500.410@eddie.linux-mips.org>
References: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
	<alpine.LFD.2.00.1009021617500.410@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Thu, 2 Sep 2010 16:20:34 +0100 (BST)

>  Arguably using a union here would make things cleaner and any reasonable 
> ABI will place small unions used as arguments or return values in 
> registers, but I'm not sure if the cost of the rewrite is worth the 

Well, sparc 32-bit's ABI for one is "not reasonable" and these return
values will always get stack slots and passed back by reference.
