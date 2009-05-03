Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 56833DDE0D
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 07:20:36 +1000 (EST)
Date: Sun, 03 May 2009 14:20:29 -0700 (PDT)
Message-Id: <20090503.142029.245176169.davem@davemloft.net>
To: rbrito@ime.usp.br
Subject: Re: [PATCH] powerpc: convert mace to netdev_ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090503.141524.253766195.davem@davemloft.net>
References: <20090427.054258.16622932.davem@davemloft.net>
	<20090503114820.GA14926@ime.usp.br>
	<20090503.141524.253766195.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Miller <davem@davemloft.net>
Date: Sun, 03 May 2009 14:15:24 -0700 (PDT)

> From: Rog=E9rio Brito <rbrito@ime.usp.br>
> Date: Sun, 3 May 2009 08:48:20 -0300
> =

>> I hope that this version is a slightly better fix to convert mace to=

>> netdev_ops.
>> =

>> This is against this morning's net-2.6 tree.
>> =

>> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>
> =

> I'll apply this, thanks!  I made one change however.

Oh, nevermind, it seems that MACE was already converted
to netdev_ops some time ago in the net-next-2.6 tree.
