Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B253AB6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 05:44:54 +1000 (EST)
Date: Mon, 18 Jul 2011 12:42:48 -0700 (PDT)
Message-Id: <20110718.124248.1462465498024218250.davem@davemloft.net>
To: eric.dumazet@gmail.com
Subject: Re: [PATCH] net: filter: BPF 'JIT' compiler for PPC64
From: David Miller <davem@davemloft.net>
In-Reply-To: <1310978375.5756.7.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
References: <4E23E5C3.1070209@ozlabs.org>
	<1310978375.5756.7.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 18 Jul 2011 10:39:35 +0200

> So in PPC SEEN_XREG only is to be set of X is read, not if written.
> 
> So you dont have to set SEEN_XREG bit in this part :

Matt, do you want to integrate changes based upon Eric's feedback
here or do you want me to apply your patch as-is for now?

Thanks.
